function [num_blue,num_red]= detect_lego(Testing_img)

%setDir_training = fullfile('training'); 

%imds_training = imageDatastore(setDir_training,'IncludeSubfolders',true,'LabelSource',... 
%    'foldernames');
%[trainingSet, testingSet] = splitEachLabel(imds_training, 0.7, 'randomize');

% Step 2: Create Bag of Features

%bagFeature = bagOfFeatures(trainingSet);

% Compute histogram of visual word occurrences for images. 
% Store the histogram as feature vector.
%featureVector = encode(bagFeature,trainingSet);

% Step 3: Train an Image Classifier With Bag of Visual Words
%categoryClassifier = trainImageCategoryClassifier(trainingSet,bagFeature);

load('Classifier.mat');
% Evaluate the classifier using test images. Display the confusion matrix.
%confMatrix = evaluate(categoryClassifier,testingSet);

% Find the average accuracy of the classification.
%mean(diag(confMatrix));

% Apply the newly trained classifier to categorize new images.

% segment images

img = Testing_img;
%greenRange = [0.4 0.5]; % Range of hue values considered 'green'
Red_Range = [0.7 1]; % Range of hue values considered 'Red'
BlueRange = [0.5 0.7]; % Range of hue values considered 'Blue'
minSat = 0.5; % Minimum saturation value for 'colored' pixels to exclude bkgd noise
minRegionsize = 500; % Min size for a single block

[numred_big,numred_small]=segmentation(img,Red_Range,minSat,minRegionsize,categoryClassifier,1);
[numblue_big,numblue_small]=segmentation(img,BlueRange,minSat,minRegionsize,categoryClassifier,2);


num_blue=numblue_big;
num_red=numred_small;


end













