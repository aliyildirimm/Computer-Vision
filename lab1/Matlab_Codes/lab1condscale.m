function [Jnew] = lab1condscale(Im, Iref)
[~,~,c] = size(Im);
if c == 3
    Im = rgb2gray(Im);
end
[~, ~,c] = size(Iref);
if c == 3
    Iref = rgb2gray(Iref);
end

J = double(Im);
I = double(Iref);

%%will make our matrix column matrix
b = std(I(:)) / std(J(:));
a = mean(I(:))/ b-mean(J(:));

Jnew = b*(J+a);
disp([mean(I(:)), mean(J(:)), mean(Jnew(:))]);
disp([std(I(:)), std(J(:)), std(Jnew(:))]);

Jnew = uint8(Jnew);

subplot(2,2, [1 2]), imshow(Iref);
title 'Reference Image'
xlabel({[ '\mu = ',num2str(mean(double(Iref(:))))], ['\sigma = ',num2str(std(double(Iref(:))))]})
subplot(2,2,3), imshow(Im);
title 'Original Image'
xlabel({[ '\mu = ',num2str(mean(double(Im(:))))], ['\sigma = ',num2str(std(double(Im(:))))]})
subplot(2,2,4), imshow(Jnew);
title 'Processed Image'
xlabel({[ '\mu = ',num2str(mean(double(Jnew(:))))], ['\sigma = ',num2str(std(double(Jnew(:))))]})
end