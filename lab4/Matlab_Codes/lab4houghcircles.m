function [centersBright, radiiBright,darks_center, darks_radi] = lab4houghcircles(I, sens, i)

    [row,col,ch] = size(I);
    img = I;
    if (ch==3)
        img = rgb2gray(img);
    end
    
    Rmin = 20;Rmax = 60;Sens = sens;

    
    
    subplot(3,3,(3*i)-2)
        imshow(I)
        title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d', Rmin, Rmax))
        hold on
        [centersBright, radiiBright] = imfindcircles(I,[Rmin Rmax],  'Sensitivity',Sens);
        viscircles(centersBright, radiiBright,'Color','b');
    
%     [centersDark,   radiiDark]   = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',Sens);
    subplot(3,3,(3*i)-1)
        imshow(img)
        title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d & Sensitivity: %f', Rmin, Rmax, Sens))
        hold on
        [whites_center, whites_radi] = imfindcircles(img,[20 60],'ObjectPolarity','bright', 'Sensitivity',Sens);
        viscircles(whites_center, whites_radi,'Color','r');
%     figure;
    subplot(3,3,(3*i))
        imshow(img)
        title(sprintf('Detected Bright and Dark Circles \n %d =< Radius =< %d & Sensitivity: %f', Rmin, Rmax, Sens))
        hold on
        [whites_center, whites_radi] = imfindcircles(img,[20 60],'ObjectPolarity','bright', 'Sensitivity',Sens);
        [darks_center, darks_radi] = imfindcircles(img,[20 60],'ObjectPolarity','dark');
        viscircles(whites_center, whites_radi,'Color','b');
        viscircles(darks_center, darks_radi,'LineStyle','--');

end
