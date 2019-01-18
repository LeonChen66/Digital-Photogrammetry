img = double(imread('lena.bmp'));
mask = [0 -1 0;-1 4 -1;0 -1 0];
out = conv2(img,mask,'same');
imshow(uint8(out))
M = size(img, 1) + size(mask, 1);
N = size(img, 2) + size(mask, 2);
fre_final = fftshift(fft2(img, M, N) .* fft2(mask, M, N));
tic
figure;
imshow(mat2gray(log(1+abs(fre_final))))
resIFFT  = ifft2(fft2(img, M, N) .* fft2(mask, M, N));
resIFFT = resIFFT(1:end-1, 1:end-1);  % # Adjust dimensions
toc
figure;
imshow(uint8(resIFFT))
figure;
af=fftshift(fft2(img));
imshow(mat2gray(log(1+abs(af))))
figure;
af2 = fftshift(fft2(mask, M, N));
imshow(mat2gray(log(1+abs(af2))))



