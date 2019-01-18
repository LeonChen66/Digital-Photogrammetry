# -*- coding: utf-8 -*-
"""
Created on Wed Nov 16 18:39:28 2016

@author: Leon
"""
import sys  
 
#Global n (number of points)

import numpy as np
import cv2

import os
import numpy as np
import cv2
from matplotlib import pyplot as plt
photo=[]
for f in os.listdir('.'):
    if f[0]=='I':
        photo.append(f)
        
global name_of_points
name_of_points = 0 
def sift(a,b,photo_number):
    global name_of_points
    MIN_MATCH_COUNT = 10

    img1 = cv2.imread(a,0)          # queryImage
    img2 = cv2.imread(b,0) # trainImage

    # Initiate SIFT detector
    sift = cv2.xfeatures2d.SIFT_create()

    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(img1,None)
    kp2, des2 = sift.detectAndCompute(img2,None)

    FLANN_INDEX_KDTREE = 0
    index_params = dict(algorithm = FLANN_INDEX_KDTREE, trees = 3)
    search_params = dict(checks = 50)

    flann = cv2.FlannBasedMatcher(index_params, search_params)

    matches = flann.knnMatch(des1,des2,k=2)

    # store all the good matches as per Lowe's ratio test.
    good = []
    for m,n in matches:
        if m.distance < 0.25*n.distance:
            good.append(m)
            indexLeft = [e.queryIdx for e in good]

            # Index of matching point in right image
            indexRight = [e.trainIdx for e in good]

            # Get coordinates of matching points
            Lcol = np.array(map(lambda i: kp1[i].pt[0], indexLeft))
            Lrow = np.array(map(lambda i: kp1[i].pt[1], indexLeft))
            Rcol = np.array(map(lambda i: kp2[i].pt[0], indexRight))
            Rrow = np.array(map(lambda i: kp2[i].pt[1], indexRight))

    print "Number of matching points: %d" % len(Lcol)

    if len(good)>MIN_MATCH_COUNT:
        src_pts = np.float32([ kp1[m.queryIdx].pt for m in good ]).reshape(-1,1,2)
        dst_pts = np.float32([ kp2[m.trainIdx].pt for m in good ]).reshape(-1,1,2)
        
        M, mask = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC,5.0)
        matchesMask = mask.ravel().tolist()
        
        h,w = img1.shape
        pts = np.float32([ [0,0],[0,h-1],[w-1,h-1],[w-1,0] ]).reshape(-1,1,2)
        dst = cv2.perspectiveTransform(pts,M)

        img2 = cv2.polylines(img2,[np.int32(dst)],True,255,3)

    else:
        print("Not enough matches are found - %d/%d" % (len(good),MIN_MATCH_COUNT))
        matchesMask = None
    
    draw_params = dict(matchColor = (0,255,0), # draw matches in green color
                   singlePointColor = None,
                   matchesMask = matchesMask, # draw only inliers
                   flags = 2)

    img3 = cv2.drawMatches(img1,kp1,img2,kp2,good,None,**draw_params)
    
    photo_number1 = photo_number+1
    photo_number2 = photo_number+2
    plt.imshow(img3, 'gray'),plt.show()
    cv2.imwrite('feature'+'{}'.format(photo_number1)+'.jpg',img3)
    with open("Output_photo.txt", "a") as text_file:
        for i in range(len(Lcol)):
            points_number = name_of_points + i
            text_file.write("{} {} {} {}\n".format(Lcol[i], Lrow[i],points_number,photo_number1))
            text_file.write("{} {} {} {}\n".format(Rcol[i], Rrow[i],points_number,photo_number2))
    text_file.close()
    
    name_of_points += len(Lcol)

    
for photo_number in range(len(photo)-1):
    a=photo[photo_number]
    b=photo[photo_number+1]
    sift(a,b,photo_number)
