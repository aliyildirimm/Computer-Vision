function [Filtered_img] = lab2gaussfilt(img)

    % Checking whether the image RGB or Grayscale and made conversion if necessary
    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    % Gaussin Matrix
    Gaussian_Matrix = (1/273.)*[    1   4   7   4    1  ;
                                    4   16  26  16   4  ;
                                    7   26  41  26   7  ;
                                    4   16  26  16   4  ; 
                                    1   4   7   4    1  ];

                                
    Filtered_img = zeros(size(img));
    % Conversion unsigned innteger type to double in order to proceed
    img = double(img);
    k = 2;
    
    % Windowing operation and convolution starting from k+1' th pixel
    % method 1
    for i = k+1:1:row-k-1
        for j = k+1:1:col-k-1
            Window = img(i-k:i+k, j-k:j+k);
            value = sum(sum(Window .* Gaussian_Matrix));
            Filtered_img(i,j) = value;
        end
    end
    
    %method 2
    %Filtered_img = conv2(img, Gaussian_Matrix, 'same');
    
    % Conversion from double to unsigned integer in order to show the image
    img = uint8(img);
    Filtered_img = uint8(Filtered_img);
end