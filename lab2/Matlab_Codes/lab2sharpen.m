function [Sharpened_img] = lab2sharpen(img, limbda, M)

    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    k = 3;
    
    % Modes
    if (M == 1)
        Smoothed = lab1locbox(img,k);
    elseif (M == 2)
        Smoothed = lab2gaussfilt(img);
    elseif (M == 3)
        Smoothed = lab2medfilt(img,k);
    end
    
    % Conversion unsigned integer type to double in order to proceed
%     img = double(img);
%     Smoothed = double(Smoothed);
%     Smoothed_1 = uint8(Smoothed);
%     subplot(2,3,4)
%     imshow(Smoothed_1)
%     title 'S(p)'
    
%     Sharpened_img = (img - Smoothed);
%     Sharpened_img_1 = uint8(Sharpened_img);
%     subplot(2,3,5)
%     imshow(Sharpened_img_1)
%     title 'I(P) - S(p)'
    
%     Sharpened_img = limbda*(img - Smoothed);
%     Sharpened_img = uint8(Sharpened_img);
%     subplot(2,3,6)
%     imshow(Sharpened_img)
%     title '\lambda * (I(P) - S(p))'
%     
    
    
    Sharpening function
    Sharpened_img = img + limbda*(img - Smoothed);
    
    % Conversion from double to unsigned integer in order to show the image
    img = uint8(img);
    Smoothed = uint8(Smoothed);
    Sharpened_img = uint8(Sharpened_img);
    
    figure('NumberTitle', 'off', 'Name', 'Sharpening');
    subplot(1,2,1)
    imshow(img)
    title 'Original Image'
    subplot(1,2,2)
    imshow(Sharpened_img)
    title 'Sharpened Image'
end