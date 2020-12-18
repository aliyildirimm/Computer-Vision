function [H,T,R] = hough_detectors(I, detector, i)
    
    img = double(I);
    % edge detection
    canny_img = edge(img, detector);
    
     % hough transform
    [H,T,R] = hough(canny_img, 'RhoResolution', 0.5, 'Theta', -90:0.5:89);
      
    % hough peaks
    Thresh = ceil(0.5*max(H(:)));
    % find 20 peaks whose value bigger than threshold (half of max)
    peaks = houghpeaks(H,20,'threshold',Thresh);
    lines = houghlines(canny_img, T, R, peaks, 'FillGap', 10, 'MinLength', 45);
    subplot(2,2,i+1)
        imshow(I), 
        hold on
        max_len = 0;
        min_len = 200;
        for k = 1:length(lines)
           xy = [lines(k).point1; lines(k).point2];
           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

           % Plot beginnings and ends of lines
           plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
           plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

           % Determine the endpoints of the longest line segment
           len = norm(lines(k).point1 - lines(k).point2);
           if ( len > max_len)
              max_len = len;
              xy_long = xy;
           end
           if( len < min_len)
               min_len = len;
               xy_short = xy;
           end
        end

        plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
        plot(xy_short(:,1),xy_short(:,2),'LineWidth',2,'Color','red');
        title(detector)
   sgtitle("Line Detection with Different Edge Detectors")
end