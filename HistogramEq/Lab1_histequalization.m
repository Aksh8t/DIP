clc;
clear;
close all;

% Read the image
I = imread("C:\Users\aksha\OneDrive\Desktop\DIP\HistogramEq\Histogram.jpg");

% Convert RGB image to grayscale if required
if size(I,3) == 3
    I = rgb2gray(I);
end


% Step 1: Image size and pixel count
[M,N] = size(I);
numPixels = M * N;

% Step 2: Calculate Histogram Manually
histCount = zeros(256,1);

for i = 1:M
    for j = 1:N
        intensity = I(i,j);
        histCount(intensity + 1) = histCount(intensity + 1) + 1;
    end
end

% Step 3: Probability Density Function (PDF)
pdf = histCount / numPixels;

% Step 4: Cumulative Distribution Function (CDF)
cdf = zeros(256,1);
cdf(1) = pdf(1);
for k = 2:256
    cdf(k) = cdf(k-1) + pdf(k);
end

% Step 5: Intensity Mapping
L = 256;
mapping = round((L - 1) * cdf);

% Step 6: Apply Mapping to get Equalized Image
I_eq = zeros(M,N,'uint8');

for i = 1:M
    for j = 1:N
        oldVal = I(i,j);
        I_eq(i,j) = mapping(oldVal + 1);
    end
end

% Step 7: Histogram of Equalized Image (Manual)
histEq = zeros(256,1);

for i = 1:M
    for j = 1:N
        val = I_eq(i,j);
        histEq(val + 1) = histEq(val + 1) + 1;
    end
end

% Step 8: Display Results
figure;

subplot(2,2,1);
imshow(I);
title('Original Image');

subplot(2,2,2);
bar(0:255, histCount);
xlim([0 255]);
title('Original Histogram');
xlabel('Intensity');
ylabel('Pixel Count');

subplot(2,2,3);
imshow(I_eq);
title('Histogram Equalized Image');

subplot(2,2,4);
bar(0:255, histEq);
xlim([0 255]);
title('Equalized Histogram');
xlabel('Intensity');
ylabel('Pixel Count');