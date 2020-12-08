%Lab3 Edge Detection
%% part 1 Sobel Edges // please comment out plotting part
clear all; close all; clc;
Img = imread('peppers.png');
Threshold = 100;
Im_sobel = lab3sobel(Img, Threshold);

%% part 2 Sobel Edges Threshold Comparison
clear all; close all; clc;
Img = imread('peppers.png');

Threshold = [0, 50, 100, 125, 150, 200, 250, 255];
figure
subplot(2,3,1)
imshow(rgb2gray(Img))
title('Original Image')
for i = 1:8
    Im_sobel = lab3sobel(Img, Threshold(i));
    subplot(2,3,i+1)
    imshow(Im_sobel)
    title ([{'Sobel Edges with Threshold = ', num2str(Threshold(i))}])
end

%% part 3 Prewitt Edges // please comment out plotting part
clear all; close all; clc;
Img = imread('peppers.png');
Threshold = 100;
Prew_edge = lab3prewitt(Img, Threshold);

%% part 4 Prewitt Edges Threshold Comparison
clear all; close all; clc;
Img = imread('object_contours.jpg');
Threshold = [0, 50, 100, 125, 150, 200, 250, 255];

figure
subplot(3,3,1)
imshow(rgb2gray(Img))
title('Original Image')

for i = 1:8
    Prew_edge = lab3prewitt(Img, Threshold(i));
    subplot(3,3,i+1)
    imshow(Prew_edge)
    title ([{'Prewitt Edges with Threshold = ', num2str(Threshold(i))}])
end

%% part 5 Sobel Edges and Prewitt Edges Comparison
clear all; close all; clc;
Img = imread('house.png');
Threshold = 100;

figure
subplot(1,3,1)
imshow(Img)
title('Original Image')

Im_sobel = lab3sobel(Img, Threshold);
subplot(1,3,2)
imshow(Im_sobel)
title ([{'Sobel Edge with Threshold = ', num2str(Threshold)}])

Prew_edge = lab3prewitt(Img, Threshold);
subplot(1,3,3)
imshow(Prew_edge)
title ([{'Prewitt Edge with Threshold = ', num2str(Threshold)}])

%% part 6 Sobel Edges and Prewitt Edges Comparison for Noisy Image
clear all; close all; clc;
Img = imread('jump.png');
figure
subplot(2,2,1)
imshow(Img)
title('Original Image')

Img = medfilt(Img);
subplot(2,2,2)
imshow(Img)
title('Median Filtered Image')
Threshold = 130;

Im_sobel = lab3sobel(Img, Threshold);
subplot(2,2,3)
imshow(Im_sobel)
title ([{'Sobel Edge with Threshold = ', num2str(Threshold)}])

Prew_edge = lab3prewitt(Img, Threshold);
subplot(2,2,4)
imshow(Prew_edge)
title ([{'Prewitt Edge with Threshold = ', num2str(Threshold)}])


%% part 7 Laplacian of Gaussian Image
clear all; close all; clc;
I=imread("object_contours.jpg");
Img = lab3log(I, 10, 90);

%% part 8 Laplacian of Gaussian Image Threshold 1 change
clear all; close all; clc;
I=imread("object_contours.jpg");
Threshold1 = [1, 5, 9];

figure
subplot(2,2,1);
imshow(rgb2gray(I));
title("Original Image");

for i=1:3
    Img = lab3log(I, Threshold1(i), 12);
    subplot(2,2,i+1);
    imshow(Img);
    title ([{'LoG while Threshold 1 =', num2str(Threshold1(i)), 'while Threshold 2 = 12'}])
end

%% part 9 Laplacian of Gaussian Image Threshold 2 change
clear all; close all; clc;
I=imread("object_contours.jpg");
Threshold2= [10, 15, 20];

figure
subplot(2,2,1);
imshow(rgb2gray(I));
title("Original Image");

for i=1:3
    Img = lab3log(I, 9, Threshold2(i));
    subplot(2,2,i+1);
    imshow(Img);
    title ([{'LoG while Threshold 1 = 9 while Threshold 2 =', num2str(Threshold2(i))}])
end