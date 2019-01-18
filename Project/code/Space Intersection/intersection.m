function y = intersection(allphoto,n,start,stop)    %n_photo begin = start point stop = stop point
allphoto;
global allphoto_1 ini  B_dot_ij B_dot2_ij b11 b12 b13 b14 b15 b16 b21 b22 b23 b24 b25 b26 J K xa ya cor  XL YL ZL XA YA ZA delta JK
%load('result2.txt');
%xa(1:46,1) =result1(1:46,1);
%xa(1:46,2) =result2(1:46,1);
%ya(1:46,1) =result1(1:46,2);
%ya(1:46,2) =result2(1:46,2);
allphoto_1 = allphoto;
if n < 6
    for i = start:stop
        ini(allphoto*6+i*3-2:allphoto*6+3*i,1)=[0;0;0];  %initial values
    end
else
    for i = start:stop
        ini(allphoto*6+i*3-2:allphoto*6+3*i,1)=[0.40675;0;0.20120];
    end
end
B_dot_ij = 0;
B_dot2_ij = 0;
JK = 0;
for iter = 1:100
for i = n:n+1
    for j = start:stop  %J is number of point 
        inter_Matrix(i,j);
        B_dot_ij(2*j-1:2*j,1:6,i) = [b11 b12 b13 -b14 -b15 -b16;b21 b22 b23 -b24 -b25 -b26];
        B_dot2_ij(2*j-1:2*j,1:3,i) = [b14 b15 b16;b24 b25 b26];
         JK(2*j-1:2*j,i) = [J;K];
    end
end
A=0;
cor = 0;
for num = start:stop
    A(1:2,1:3) = B_dot2_ij(2*num-1:2*num,1:3,n);
    A(3:4,1:3) = B_dot2_ij(2*num-1:2*num,1:3,n+1);
    L(1:2,1) = JK(num*2-1:2*num,n);
    L(3:4,1) = JK(num*2-1:2*num,n+1);
    delta(1:3,1) = inv(A'*A)*(A'*L);
    cor(num*3-2:num*3) = delta;
end

ini(allphoto*6+start*3-2:allphoto*6+stop*3)=cor(start*3-2:stop*3)'+ ini(allphoto*6+start*3-2:allphoto*6+stop*3);
end