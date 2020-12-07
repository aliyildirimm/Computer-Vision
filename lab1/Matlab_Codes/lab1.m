%% Linear Scaling
clc; clear;close all;

Im = imread('darkimage.png');

[Inew] = lab1linscale(Im);

%% Conditional Scaling
clc; clear;close all;
Im = imread('darkimage.png');
Iref = imread('board.jpg');

[Jnew] = lab1condscale(Im, Iref);

%% Box Filter 
clc; clear;close all
Im2 = imread('jump.png');
[Inew] = lab1locbox(Im2);

%% Min/Max Filter 
clc; clear;close all
Im = imread('currentImage.png');
[Imax, Imin] = lab1locmaxmim(Im);