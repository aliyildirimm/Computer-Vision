%% Part 1: Linear Filtering Gausian

clear all; close all; clc;

img = imread('jump.png');
ResImg = lab2gaussfilt(img);
figure
subplot(1,2,1)
imshow(img)
title 'Original Image'
subplot(1,2,2)
imshow(ResImg)
title 'Gaussian Filtered Image'

%% Part 2:Non Linear Filtering(Median)

clear all; close all; clc;

img = imread('Tiger.png');
kvals = [1, 2, 3, 4, 5];
figure
for i = 1:5
    ResImg = lab2medfilt(img, kvals(i));
    
    subplot(1,5,i)
    imshow(ResImg)
    title ([{'Median Filtered Image with k= ', num2str(kvals(i))}])
end

%% Part 3: Sharpening

clear all; close all; clc;

img = imread('mother.png');
Mode = 3;
%limbda = 5;
% Mode_vals = [1,2,3];
% figure
% subplot(2,3,2)
% imshow(img)
% title 'Original Image'
% for i=1:3
%     ResImg = lab2sharpen(img,limbda, Mode_vals(i));
%     subplot(2,3,3+i)
%     imshow(ResImg)
%     title ([{'Shapened Image with Mode = ', num2str(Mode_vals(i))}])
% end

% limbda_vals = [1, 5, 25];
% for i=1:3
%     ResImg = lab2sharpen(img, limbda_vals(i), Mode);
%     subplot(2,3,3 + i)
%     imshow(ResImg)
%     title ([{'Shapened Image with limbda = ', num2str(limbda_vals(i))}])
% end

limbda = 10;
ResImg = lab2sharpen(img, limbda, Mode);
%% Part 4: Sobel

clear all; close all; clc;

img = imread('colleseum.jpg');
[x_filtered, y_filtered] = lab2sobelfilt(img);