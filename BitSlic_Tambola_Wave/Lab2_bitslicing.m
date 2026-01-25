clc;
clear all;
close all;


I = imread('C:\Users\aksha\Downloads\ironman.png');

% Convert to grayscale if image is RGB
if size(I,3) == 3
    I = rgb2gray(I);
end

[rows, cols] = size(I);   % number of rows and columns

figure;
imshow(I);

% Store bit planes (8-bit image → 8 planes)
bit_planes = zeros(rows, cols, 8);

for k = 1:8                      % for each bit
    power = 2^(k-1);
    
    for i = 1:rows               % for each row
        for j = 1:cols           % for each column
            bit_planes(i,j,k) = mod(floor(double(I(i,j)) / power), 2);
        end
    end
end

% Display bit planes
figure;
for k = 1:8
    subplot(2,4,k)
    imshow(bit_planes(:,:,k), [])
    title(['Bit Plane ', num2str(k)])
end
