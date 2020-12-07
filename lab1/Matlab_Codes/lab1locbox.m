function [Inew] = lab1locbox(Im)

k_val = [1 2 5 7 10];
subplot(2,3,1), imshow(Im);
title 'Original Image'
for p = 1:5
    k = k_val(p);
    I = double(Im);
    [h,w,c] = size(I);

    Inew = I;
    for i= k+1:h-k
        for j= k+1:w-k
            wp = I(i-k:i+k, j-k:j+k);
            Inew(i,j) = mean(wp(:));
        end
    end

    Inew = uint8(Inew);
    subplot(2,3,p+1), imshow(Inew);
    title ({['Box Filtered Image k = ', num2str(k)]})
end

end 