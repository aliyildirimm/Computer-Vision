function [Filtered_img] = medfilt(img)
    
    k = 1;
    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    img = double(img);
    Filtered_img = zeros(size(img));
    
    for i = k+1:1:row-k-1
        for j = k+1:1:col-k-1
            Window = img(i-k:i+k, j-k:j+k);
            value = myMedian(Window);
            Filtered_img(i,j) = value;
        end
    end
    Filtered_img = uint8(Filtered_img);
end
    