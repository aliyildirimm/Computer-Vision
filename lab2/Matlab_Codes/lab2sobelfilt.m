function [x_filtered, y_filtered] = lab2sobelfilt(img)
    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    % Conversion unsigned integer type to double in order to proceed
    img = lab2gaussfilt(img);
    img = double(img);
    
    % Kernels
    x_Filter = [-1,0,1;-2,0,2;-1,0,1];
    y_Filter = [-1,-2,-1;0,0,0;1,2,1];
    k = 1;
    
    % Windowing operation and convolution starting from k+1' th pixel
    % method 1
    for i = k+1:1:row-k-1
        for j = k+1:1:col-k-1
            Window = img(i-k:i+k, j-k:j+k);
            Xvalue = sum(sum(Window .* x_Filter));
            Yvalue = sum(sum(Window .* y_Filter));
            x_filtered(i,j) = Xvalue;
            y_filtered(i,j) = Yvalue;
        end
    end
    
    % Conversion from double to unsigned integer in order to show the image
    img = uint8(img);
    x_filtered = uint8(x_filtered);
    y_filtered = uint8(y_filtered);
    
    figure;
    subplot(2,2,[1 2])
        imshow(img)
        title('Original Image');
    subplot(2,2,3)
        imshow(x_filtered)
        title('Sobel Horizontal Filtered Image: Vertical Edgels');
    subplot(2,2,4)
        imshow(y_filtered)
        title('Sobel Vertical Filtered Image: Horizontal Edgels');

end 