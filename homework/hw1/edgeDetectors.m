function [] = edgeDetectors(Iorig, imagefiles, ii ,noise)

    %I = imgaussfilt(Iorig);
    I = Iorig;
    tic
    Ipre = edge(I,'Prewitt');
    p=toc;

    tic
    Irob = edge(I,'Roberts');
    r=toc;

    tic
    Ican = edge(I,'Canny');
    c=toc;

    tic
    Ilog = edge(I,'log');
    l=toc;
    
    figure('Units','normalized','Position',[0 0 1 1]);
    subplot(2,3,[1;4]);
        imshow(Iorig); 
        if(noise == 1) 
            title('Original Image with Noise'); 
        else
            title('Original Image'); 
        end
    subplot(2,3,2);
        imshow(Ipre);title('Prewitt Operator');xlabel(['Elapsed Time: ', num2str(p)])
    subplot(2,3,3);
        imshow(Irob);title('Roberts Operator'); xlabel(['Elapsed Time: ', num2str(r)])
    subplot(2,3,5);
        imshow(Ican);title('Canny Operator') ;xlabel(['Elapsed Time: ', num2str(c)])
    subplot(2,3,6);
        imshow(Ilog);title('Laplacian Operator');xlabel(['Elapsed Time: ', num2str(l)])
    
    if(noise == 1)
        outname = append('noisy_output_', imagefiles(ii).name);
    else
        outname = append('output_', imagefiles(ii).name);
    end
    
    saveas(gcf,"./results/"+outname,'jpg');
end