img = double(imread('lena.bmp'));
mask = [0 -1 0;-1 4 -1;0 -1 0];
M = size(img, 1) + size(mask, 1);
N = size(img, 2) + size(mask, 2);
A = img;
k = mask;
tic
for i = 1:1000
[r c] = size(A);
[m n] = size(k);
h = rot90(k, 2);
center = floor((size(h)+1)/2);
left = center(2) - 1;
right = n - center(2);
top = center(1) - 1;
bottom = m - center(1);
Rep = zeros(r + top + bottom, c + left + right);
for x = 1 + top : r + top
    for y = 1 + left : c + left
        Rep(x,y) = A(x - top, y - left);
    end
end
B = zeros(r , c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : m
            for j = 1 : n
                q = x - 1;
                w = y -1;
                B(x, y) = B(x, y) + (Rep(i + q, j + w) * h(i, j));
            end
        end
    end
end
    %out = conv2(img,mask,'same');
    %resIFFT  = ifft2(fft2(img, M, N) .* fft2(mask, M, N));
    %resIFFT = resIFFT(1:end-1, 1:end-1);  % # Adjust dimensions
end
toc