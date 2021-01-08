clear all; close all; clc;
% take input image and find edges:
img = imread('my3d.jpg');
[row, col, ch]=size(img);
if ch==3
    img_gray = rgb2gray(img);
end

img_edge = edge(img_gray,'canny');
%imshow(img_edge);

%- HOUGH TRANSFORM - Extract Lines
[H,Theta,Rho] = hough(img_edge, 'RhoResolution', 0.5, 'Theta', -90:0.5:89);
% Thresh = ceil(0.5*max(H(:)));
peaks = houghpeaks(H, 100, 'threshold', 0.3*max(H(:)));
% fill parameters accordingly: fill gap: up to 25 cm gap combine lines
%                            : Minlength: a line must be at least 70 cm
lines = houghlines(img_edge, Theta, Rho, peaks, 'FillGap', 90, 'MinLength', 180);

%- PLOT HOUGH LINES  
figure('Units','normalized','Position',[0 0 1 1]);
subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(img_gray)
hold on
% plot the lines on the image
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    % plot the line
    plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','green'); % first column vs second column? çünkü bir row vector.
    % plot the beginning and the end of the line
    plot(xy(1,1),xy(1,2),'x','MarkerSize',12,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','MarkerSize',12,'Color','red');
end
saveas(gcf,"./my3d_linedetection","jpg")
hold off

 
x_v = 0:1:size(img,1);
%intersecting lines are hold in pairs struct
pairs = [lines(3), lines(15); lines(3), lines(37); lines(3), lines(33)
         lines(5), lines(15); lines(5), lines(37); lines(5), lines(33)
         lines(9), lines(15); lines(9), lines(37); lines(9), lines(33)];

% this arrays are created to hold line equations in a table.
formula_1=[];
formula_2=[];
intersections=[];

figure
imshow(img)
hold on 
for i = 1:length(pairs)
    b = [pairs(i,1).rho; pairs(i,2).rho];
    A = [cosd(pairs(i,1).theta) sind(pairs(i,1).theta); cosd(pairs(i,2).theta) sind(pairs(i,2).theta)];
    
    y1 = (pairs(i,1).rho - x_v*cosd(pairs(i,1).theta))/sind(pairs(i,1).theta);
    plot(x_v,y1, 'LineWidth',2,'Color', 'm');
    y2 = (pairs(i,2).rho - x_v*cosd(pairs(i,2).theta))/sind(pairs(i,2).theta); 
    plot(x_v,y2,'LineWidth',2,'Color' , 'm');
    C = A\b;
    
    plot(C(1), C(2), '-m*','MarkerSize',10);
    
    formula1= "y1=("+string(pairs(i,1).rho)+"-x*cos("+string(pairs(i,1).theta)+")/sin("+string(pairs(i,1).theta)+")";
    formula2= "y2=("+string(pairs(i,2).rho)+"-x*cos("+string(pairs(i,2).theta)+")/sin("+string(pairs(i,2).theta)+")";
    formula_1 =[formula_1; formula1];
    formula_2 =[formula_2; formula2];
    intersections=[intersections; C(1), C(2)];
    
    Text = 'Corner %i: (%i,%i) and the lines passing through it: \n' + formula1 + "\n" + formula2 + "\n";
    fprintf(Text, i,round(C(1)),round(C(2)));
end 
saveas(gcf,"./my3d_corners_from_line","jpg")
corners = corner(img_gray, 'harris');
plot(corners(:,1), corners(:,2),'o','MarkerSize',4,'MarkerEdgeColor','blue','LineWidth',1);
%- distance calculation for one corner point:
harris = [527 ,691];
line = [ 528 , 691.8 ];
distance = sqrt((harris(1)-line(1))^2 + (harris(2)-line(2))^2);
fprintf("\nFor Corner at (529, 693), distance difference between methods is %f. \n", distance);
saveas(gcf,"./my3d_corners_from_+_harris","jpg")


%%
% plotting those two plots on the same figure
% Iorig1= imread('my3d_corners_from_line.jpg');
% Iorig2= imread('my3d_corners_from_+_harris.jpg');
% figure;
% imshowpair(Iorig1, Iorig2, 'montage');
% saveas(gcf,"./comparison_line_vs_harris", "jpg")
% close all;
%- plotting zoomed figures
% Iorig2= imread('zoom_second.png');
% Iorig3= imread('zoom_third.png');
% figure('Units','normalized','Position',[0 0 1 1]);
% 
% subplot(1,2,1)
%     imshow(Iorig2)
%     xlabel('Line Performs Better')
% subplot(1,2,2)
%     imshow(Iorig3)
%     xlabel('Harris Performs Better')
% saveas(gcf,"./comparison_zoom", "jpg")
% close all;
% 
% Iorig4= imread('center1.jpg');
% Iorig5= imread('center2.jpg');
% Iorig6= imread('far1.jpg');
% Iorig7= imread('far2.jpg');
% figure('Units','normalized','Position',[0 0 1 1]);
% subplot(1,2,1)
%     imshow(Iorig4)
% subplot(1,2,2)
%     imshow(Iorig5)
% sgtitle("Corners Near Center")
% saveas(gcf,"./center", "jpg")
% figure('Units','normalized','Position',[0 0 1 1]);
% subplot(1,2,1)
%     imshow(Iorig6)
% subplot(1,2,2)
%     imshow(Iorig7)
% sgtitle("Corners Far From Center")
% saveas(gcf,"./far", "jpg")
% close all;
%
% T = table(intersections,formula_1,formula_2);
% saveas(gcf,"./table", "jpg");