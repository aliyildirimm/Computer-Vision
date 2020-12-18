%% Corner Detection
% corner detection comparison for 3 different images
clear all; close all; clc;
image_array = [ "Monastry.bmp", "chess.jpg", "blocks.png"];
figure;
for i=1:3
    tic
    img  = imread(image_array(i));
    threshold = 40000;
    Corners = lab4ktcorners(img, threshold);
    elapsed = toc;
    
    subplot(1,3,i)
        if (length(size(img)) ==3)
            img = rgb2gray(img);
        end
        imshow(img)
        hold 
        plot(Corners(:,2),Corners(:,1),'r.', 'MarkerSize', 7, 'Linewidth', 2);
        title({"Elapsed Time: ", num2str(elapsed)});
end
sgtitle('Kanade-Tomasi Corner Detection');

% Changing threshold effect on corner detection
img  = imread('blocks.png');
threshold = [5000; 30000; 100000];
figure;
for i=1:3
    tic
    Corners = lab4ktcorners(img, threshold(i));
    elapsed = toc;
    
    subplot(1,3,i)
        imshow(img)
        hold 
        plot(Corners(:,2),Corners(:,1),'r.', 'MarkerSize', 7, 'Linewidth', 2);
        title({"Threshold: ", num2str(threshold(i)), "Elapsed Time: ", num2str(elapsed)});
end
sgtitle('Kanade-Tomasi Corner Detection with Changing Threshold');
%% Line Detection

clear all; close all; clc;
tic;
%img  = imread('checker.jpg');
% road image
img  = imread('road.jpg');
[H, theta, rho] = lab4houghlines(img);
elapsed = toc;

%% Line Detection - different edge detectors

clear all; close all; clc;

img  = imread('checker.jpg');
[r,c, ch] = size(img);
if ch == 3
    img = rgb2gray(img);
end
figure;
subplot(2,2,1)
    imshow(img);
    title('Original Image');    
detector = [ "Canny", "Prewitt", "log"];
for i = 1:3
    [H, theta, rho] = hough_detectors(img, detector(i), i);
end
%% Circle Detection

clear all; close all; clc;
tic
img  = imread('circlesBrightDark.png');
Sens = [0.1, 0.6, 0.9];
figure
for i= 1:3
    [centersBright, radiiBright, centersDark, radiiDark] = lab4houghcircles(img, Sens(i), i);
end
toc