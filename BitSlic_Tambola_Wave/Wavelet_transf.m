clc;
clear all;
close all;

% Read image
I = imread('C:\Users\aksha\OneDrive\Desktop\DIP\BitSlic_Tambola_Wave\sample2.jpg');

% Convert to grayscale if RGB
if size(I,3) == 3
    Ig = rgb2gray(I);
else
    Ig = I;
end

% Convert to double
Ig = double(Ig) / 255;

% Display original image
figure;
imshow(Ig, []);
title('Original Image');

% -------- Manual Haar Wavelet Transform --------
[Ia, Iv, Ih, Id] = haar_dwt2(Ig);

% Manual normalization (NO mat2gray)
Ia2 = normalize_uint8(Ia);
Iv2 = normalize_uint8(Iv);
Ih2 = normalize_uint8(Ih);
Id2 = normalize_uint8(Id);

% Display results
figure;
subplot(2,2,1);
imshow(Ia2);
title('Approximation');

subplot(2,2,2);
imshow(Iv2);
title('Vertical');

subplot(2,2,3);
imshow(Ih2);
title('Horizontal');

subplot(2,2,4);
imshow(Id2);
title('Detailed');


% ----------------- FUNCTIONS -----------------

function [Ia, Iv, Ih, Id] = haar_dwt2(I)
    [rows, cols] = size(I);
    rows = floor(rows/2)*2;
    cols = floor(cols/2)*2;
    I = I(1:rows, 1:cols);

    Ia = zeros(rows/2, cols/2);
    Ih = zeros(rows/2, cols/2);
    Iv = zeros(rows/2, cols/2);
    Id = zeros(rows/2, cols/2);

    for i = 1:2:rows
        for j = 1:2:cols
            a = I(i, j);
            b = I(i, j+1);
            c = I(i+1, j);
            d = I(i+1, j+1);

            Ia((i+1)/2, (j+1)/2) = (a + b + c + d) / 2;
            Ih((i+1)/2, (j+1)/2) = (a - b + c - d) / 2;
            Iv((i+1)/2, (j+1)/2) = (a + b - c - d) / 2;
            Id((i+1)/2, (j+1)/2) = (a - b - c + d) / 2;
        end
    end
end

function out = normalize_uint8(in)
    minVal = min(in(:));
    maxVal = max(in(:));

    if maxVal - minVal == 0
        out = uint8(zeros(size(in)));
    else
        out = uint8(255 * (in - minVal) / (maxVal - minVal));
    end
end
