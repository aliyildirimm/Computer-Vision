function [corner_list] = lab4ktcorners(img,threshold)

    [r,c,ch] = size(img);
    if (ch ==3)
        img = rgb2gray(img);
    end

    img = double(img);
    corner_list = [];
    k=1;

    %smoothing
    Simg = imgaussfilt(img);
    %finding gradient
    [Gx,Gy] = imgradientxy(Simg); 

    for i = k+1:1:r-k-1
        for j=k+1:1:c-k-1
            Gx_win = Gx(i-k:i+k,j-k:j+k);
            Gy_win = Gy(i-k:i+k,j-k:j+k);

            I_x2= sum(sum(Gx_win .* Gx_win));
            I_xy= sum(sum(Gx_win .* Gy_win));
            I_y2= sum(sum(Gy_win .* Gy_win));

            H = [I_x2, I_xy;
                 I_xy, I_y2];
            e = eig(H);
%             lambda1 = e(1);
%             lambda2 = e(2);

            if (min(e(1),e(2)) > threshold)
                corner_list = [corner_list; i,j];
            end

        end
    end
    img = uint8(img);

end