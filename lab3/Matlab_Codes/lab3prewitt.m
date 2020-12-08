function [Prew_edge] = lab3prewitt(img , T)
    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    % Conversion unsigned integer type to double in order to proceed
    % img = lab2gaussfilt(img);
    img = double(img);
    
    % Kernels
    x_Filter = [-1,0,1;-1,0,1;-1,0,1];
    y_Filter = [-1,-1,-1;0,0,0;1,1,1];

    G_X = conv2(img, x_Filter,'same');
    G_Y = conv2(img, y_Filter,'same');
    Gradient = sqrt(G_X.*G_X + G_Y.*G_Y);
    Prew_edge = zeros(size(img));
    Prew_edge(find(Gradient > T)) = 255;
    
    img = uint8(img);
    Prew_edge = uint8(Prew_edge);

%     figure;
%     subplot(2,3,1)
%         imshow(img)
%         title('Original Image');
%     subplot(2,3,2)
%         imshow(uint8(G_X))
%         title('Prewitt X Filtered Image');
%     subplot(2,3,3)
%         imshow(uint8(G_Y))
%         title('Prewitt Y Filtered Image');
%     subplot(2,3,5)
%         imshow(uint8(Gradient))
%         title('Prewitt Gradient');
%     subplot(2,3,6)
%         imshow(Prew_edge)
%         title('Prewitt Edges');

end