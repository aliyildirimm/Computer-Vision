function [Imax, Imin] = lab1locmaxmim(Im)

k_val = [2 3 5];
I = double(Im);
[h,w,c] = size(I);

subplot(3,3, 4), imshow(Im);
title 'Original Image'

Imax = zeros(h,w);
Imin = zeros(h,w);
for p = 1:3
    k = k_val(p);
    for i= k+1:h-k
        for j= k+1:w-k
            wp = I(i-k:i+k, j-k:j+k);
            Imax(i,j) = max(wp(:));
            Imin(i,j) = min(wp(:));
        end
    end

    Imax = uint8(Imax);
    Imin = uint8(Imin);
    subplot(3,3, 3*p - 1), imshow(Imax);
    title ({['Local max filtered Image k = ', num2str(k)]})
    subplot(3,3, 3*p), imshow(Imin);
    title ({['Local min filtered Image k = ', num2str(k)]})
end

end