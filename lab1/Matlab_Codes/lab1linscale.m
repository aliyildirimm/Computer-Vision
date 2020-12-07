function [Inew] = lab1linscale(Im)

[h,w,c] = size(Im);

if c == 3
    Im = rgb2gray(Im);
end

I = double(Im);

%%I matrix will be a column matrix
a = -min(I(:));
Gmax = 255;
b = Gmax / (max(I(:)) - min(I(:)));

Inew = b * (I + a);
Inew = uint8(Inew);

subplot(2,2,1)
imshow(Im);
title 'Original Image'
subplot(2,2,2)
imshow(Inew);
title 'Linearly Scaled Image'
subplot(2,2,3)
histogram(Im);
title 'Histogram of Original Image'
subplot(2,2,4)
histogram(Inew);
title 'Histogram of Linearly Scaled Image'
end