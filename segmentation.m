function[num_big,num_small] = segmentation(image,greenRange,minSat,minRegionsize,categoryClassifier,figure_num)
%image = imread('training_images/train11.jpg');
%img=red;
%greenRange = [0.4 0.5]; % Range of hue values considered 'green'
%Red_Range = [0.7 1]; % Range of hue values considered 'Red'
%BlueRange = [0.5 0.7]; % Range of hue values considered 'Blue'
%greenRange = [0.5 0.7]; % Test
%minSat = 0.5; % Minimum saturation value for 'colored' pixels to exclude bkgd noise
%minRegionsize = 500; % Min size for a single block
%figure_num=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_big=0;
num_small=0;
%%%%%%%%%%%%%%%%%%%
% Denoise with a gaussian blur

imgfilt = imfilter(image, fspecial('gaussian', 10, 2));

% Convert image to HSV format
hsvImg = rgb2hsv(imgfilt);

% Threshold hue to get only green pixels and saturation for only colored
% pixels
greenBin = hsvImg(:,:,1) > greenRange(1) & hsvImg(:,:,1) < greenRange(2) & hsvImg(:,:,2) > minSat;
%greenBin = bwmorph(greenBin, 'close'); % Morphological closing to take care of some of the noisy thresholding

greenBin = bwmorph(greenBin, 'close'); % Morphological closing to take care of some of the noisy thresholding

% Use regionprops to filter based on area, return location of green blocks
regs = regionprops(greenBin, 'Area', 'Centroid', 'BoundingBox');
% Remove every region smaller than minRegionSize
regs(vertcat(regs.Area) < minRegionsize) = [];

% Display image with bounding boxes overlaid
figure(figure_num);
imagesc(image);
axis image
hold on


for k = 1:length(regs)
    plot(regs(k).Centroid(1), regs(k).Centroid(2), 'cx');
    boundBox = repmat(regs(k).BoundingBox(1:2), 5, 1) + [0 0; ...
        regs(k).BoundingBox(3) 0;...
        regs(k).BoundingBox(3) regs(k).BoundingBox(4);...
        0 regs(k).BoundingBox(4);...
        0 0];    
    figure(figure_num);
    plot(boundBox(:,1), boundBox(:,2), 'r');
   
    % segmentation of image
   
    y_max=max(boundBox(:,1));
    y_min=min(boundBox(:,1));
    x_max=max(boundBox(:,2));
    x_min=min(boundBox(:,2));
    [img_x,img_y, img_dim] = size(image);
    if y_max > img_y
        y_max=img_y;
    end
    
    if x_max > img_x
        x_max = img_x;
    end
    
    segment_sub=image(round(x_min):round(x_max),round(y_min):round(y_max),:);
    %segment_sub=image_sharp(segment_sub);
    
% Use classification to detect image 
    img_predict = segment_sub;

    if size(img_predict)~=0
        [labelIdx, score] = predict(categoryClassifier,img_predict);
        % Display the classification label.
        categoryClassifier.Labels(labelIdx);
        lable_name = categoryClassifier.Labels{labelIdx};
        
        if isequal(lable_name,'big') 
            if score(labelIdx) > -0.40
                num_big = num_big +1;
            end
        end
        if isequal(lable_name,'small')  
            if score(labelIdx) > -0.40
                num_small = num_small +1;
            end
        end
    end 
    
end
  
hold off

end
