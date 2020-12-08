function [loc_mean] = lab1locbox(Im, k)
    I_orig =Im;
    loc_mean = zeros (size(Im)); 
    [row,col,ch] = size(Im);
    if ch ==3
        Im = rgb2gray(Im);
    end
    Im = double(Im);

    for i=(k+1):1:(row-k-1)
        for j=(k+1):1:(col-k-1)
            windowed_image = Im(i-k:i+k,j-k:j+k);
            local_mean = mean(windowed_image(:));
            local_mean = uint8(local_mean);
            loc_mean(i,j) = local_mean;
        end
    end
    loc_mean = uint8(loc_mean); 

end