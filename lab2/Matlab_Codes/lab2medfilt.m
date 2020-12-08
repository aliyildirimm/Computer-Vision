function [Filtered_img] = lab2medfilt(img, k)
    
    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    % Conversion unsigned innteger type to double in order to proceed
    img = double(img);
    Filtered_img = zeros(size(img));
    GaussianFiltered = lab2gaussfilt(img);
    
    % Windowing operation and taking the mean of the window, starting from
    % k+1' th pixel
    for i = k+1:1:row-k-1
        for j = k+1:1:col-k-1
            Window = img(i-k:i+k, j-k:j+k);
            value = myMedian(Window);
            Filtered_img(i,j) = value;
        end
    end
    
    % Conversion from double to unsigned integer in order to show the image
    img = uint8(img);
    Filtered_img = uint8(Filtered_img);
    
%     figure
%     subplot(1,3,1)
%     imshow(img)
%     title 'Original Image'
%     subplot(1,3,2)
%     imshow(GaussianFiltered)
%     title 'Gaussian Filtered Image'
%     subplot(1,3,3)
%     imshow(Filtered_img)
%     title 'Median Filtered Image'
end