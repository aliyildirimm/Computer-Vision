function [Filtered_img] = lab2gaussfilt(img)

    [row, col, ch] = size(img);
    if(ch == 3)
        img = rgb2gray(img);
    end
    
    Gaussian_Matrix = (1/273.)*[    1   4   7   4    1  ;
                                    4   16  26  16   4  ;
                                    7   26  41  26   7  ;
                                    4   16  26  16   4  ; 
                                    1   4   7   4    1  ];
                                
    Filtered_img = zeros(size(img));
    img = double(img);
    Filtered_img=conv2(img, Gaussian_Matrix,'same');

    Filtered_img = uint8(Filtered_img);
    
end