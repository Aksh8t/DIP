clc;            % Clears the command window
clear;          % Removes all variables from the workspace
close all;      % Closes all open figure windows

% Read the input image from file
I = imread("C:\Users\aksha\Downloads\trial.jpg");

% Display the original color image
imshow(I);

figure          % Open a new figure window

% Convert the RGB image to grayscale
Ig = rgb2gray(I);

% Display the grayscale image
imshow(Ig);

% Create a copy of the original image
Ir = I;

% Set Green channel to zero (remove green component)
Ir(:,:,2) = 0;

% Set Blue channel to zero (remove blue component)
Ir(:,:,3) = 0;

figure          % Open a new figure window

% Display the red channel–only image
imshow(Ir);

% Generate a random 4x4 matrix (commented)
% aa = randi([0 10], 4, 4);

% Convert the matrix to binary based on condition (commented)
% aa = aa > 4;

% Convert grayscale image to binary using threshold value 100
Ib = Ig > 100;

figure          % Open a new figure window

% Display the binary image
imshow(Ib);
