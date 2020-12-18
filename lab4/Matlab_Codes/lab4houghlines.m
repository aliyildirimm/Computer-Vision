function [H,T,R] = lab4houghlines(I)
    [r,c, ch] = size(I);
    figure
        subplot(2,2,1)
        imshow(I)
        title('Original Image')
    if ch == 3
       img = rgb2gray(I);
    end
    img = double(img);
    % edge detection
    % for road image make canny prewitt
%     canny_img = edge(img, 'Roberts');
    canny_img = edge(img, 'Canny');
    subplot(2,2,2)
        imshow(canny_img);
        title('Edges of the Original Image by Canny Edge Detector');
    
     % hough transform
    [H,T,R] = hough(canny_img, 'RhoResolution', 0.5, 'Theta', -90:0.5:89);
    subplot(2,2,[3 4])
        imshow((rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit')
        xlabel('\theta'), ylabel('\rho');
        title('Hough Transform');
        axis on, axis normal, hold on;
      
    % hough peaks
    % used for road image Thresh = ceil(0.2*max(H(:))); && also make number
    % of peaks as 50
    
    Thresh = ceil(0.5*max(H(:)));
    % find 20 peaks whose value bigger than threshold (half of max)
    peaks = houghpeaks(H,20,'threshold',Thresh);
    figure;
        % H with respect to theta and rho
        imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
        xlabel('\theta'), ylabel('\rho');
        axis on, axis normal, hold on;
        title('20 Peaks of Hough Transform with Default (0.5 of maximum Hough points Threshold )')
        plot(T(peaks(:,2)),R(peaks(:,1)),"s",'color','white');
%     
    % hough lines
    % extracts line segments in the image BW associated with particular bins in a Hough transform. 
    % theta and rho are vectors returned by function hough. peaks is a matrix returned by the houghpeaks 
    % function that contains the row and column coordinates of the Hough transform bins to use in searching for line segments. 
    % The return value lines contains information about the extracted line segments.
    
    % if two lines's(having same slope) distance less than FillGap they became new line
    % if a line is less than predetirmened Minlength, then the line is discarded
    % for road image make fillgap: minlength: 
    % next line used for road image:
    % lines = houghlines(canny_img, T, R, peaks, 'FillGap', 20, 'MinLength', 30);
    lines = houghlines(canny_img, T, R, peaks, 'FillGap', 10, 'MinLength', 45);
    figure
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
        title('Found Shortest (Red) and Longest (Cyan) Lines');
end