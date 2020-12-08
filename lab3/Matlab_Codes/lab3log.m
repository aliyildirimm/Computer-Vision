function [Res_img] = lab3log(img,T1,T2)

    img_gauss=gaussfilt(img);
    filter=[0 1 0; 1 -4 1; 0 1 0];
    G=conv2(double(img_gauss), filter,'same');
    
    [row, col, ch] = size(img);
    if(length(size(img))==3)
        img = rgb2gray(img);
    end
    
    %Initialization
    E=zeros(row,col);
    k = 1;
    
    for i = k+1:row-k
        for j = k+1:col-k
             
            if(abs(G(i,j)) >= T1)
                if((G(i,j-1) * G(i,j))<0 || (G(i+1,j)*G(i,j))<0 || ...
                    (G(i,j+1) * G(i,j))<0 || (G(i-1,j)*G(i,j))<0)

                    if(abs(G(i,j)-G(i,j+1))>=T2 || abs(G(i-1,j)-G(i,j))>=T2 || ...
                       abs(G(i,j)-G(i+1,j))>=T2 || abs(G(i,j)-G(i,j-1))>=T2)
                        E(i,j)=255;
                    end
                end
            else
                if(G(i,j) < T1)
                    if((G(i,j+1) * G(i,j-1))<0 || (G(i+1,j)*G(i-1,j))<0 )
                        if(abs(G(i,j-1)-G(i,j+1))>=T2)
                            E(i,j)=255;
                        end
                        if(abs(G(i+1,j)-G(i-1,j))>=T2)
                           E(i,j)=255;
                        end  
                    end
                end
            end
        end
    end
    Res_img=E;
    Res_img=uint8(Res_img);
    
%     figure
%        subplot(1,3,1);
%         imshow(uint8(img));
%         title("Original Image");
%     subplot(1,3,2);
%         imshow(G, []);
%         title("Laplacian of an image");
%     subplot(1,3,3);
%         imshow(medfilt(Res_img));
%         title("LoG Edges");
end