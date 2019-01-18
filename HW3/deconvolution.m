I = imread('lena.bmp');
img = double(imread('lena.bmp'));
h = fspecial('motion',25,45);
Motion = imfilter(I,h,'replicate');
imshow(Motion)
M = size(img, 1) + size(h, 1);
N = size(img, 2) + size(h, 2);
af2 = fftshift(fft2(h, M, N));
figure;
imshow(mat2gray(log(1+abs(af2))));
fre_final = fftshift(fft2(img, M, N) .* fft2(h, M, N)); % dot
figure;
imshow(mat2gray(log(1+abs(fre_final))))
resIFFT  = ifft2(fft2(img, M, N) .* fft2(h, M, N));
resIFFT = resIFFT(1:end-1, 1:end-1);  % # Adjust dimensions
figure;
imshow(uint8(resIFFT))

blur_spetrum=fft2(img, M, N) .* fft2(h, M, N);
clear_img = ifft2(blur_spetrum./fft2(h, M, N));
clear_img = clear_img(1:end-1 , 1:end-1); % Adjust dimensions
figure;
imshow(uint8(clear_img))