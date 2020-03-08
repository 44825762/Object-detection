% Strategy:
% 1. Create Bag of Features
% 2. Compute the histogram of visual word occurrences for images.
% 3. Store the histogram as a feature vector.
% 4. Train an Image Classifier With Bag of Visual Words.
% 5. Evaluate the classifier using test images.
% 6. Find the average accuracy of the classification.
% 7. Apply the newly trained classifier to categorise new images.
% 8. Segment the test image by colour using HSV colour space.
% 9. Apply the classifier to detect the test image.
%
%
% Issues in my project:
% 1. The visual words dictionary is maintained, but the classifier does not.
% The classifier varies between each training result because I just have
% 12 images. It is not enough to train a good classifier. So, the result
% may not be calculated accurately. But, I did calculate the number of red
% blocks and blue blocks.
% 
% 2. I think another reason why my classifier does not work so good is
% the image segmentation. There is a case that two blue blocks are put
% together, the colour segmentation can not segment them into two objects. So,
% I think we can use HoughTransform to check whether there is a rectangle
% in segmented images. So, if there is a rectangle, we can segment them to
% two images. So that we can calculate the number of blocks accurately.
% I already did circle detector by HoughTransform, but I do not have time
% to do rectangle detector by HoughTransform. Sorry for the poor result.
%
% 3. In fact, I already trained a very very good classifier which can deal
% all the training images, but sadly, I retrained the classifier and it`s
% performance become worse and worse.
%
% In addition, to make you check my work easier, I put a trained classifier
% in the folder. I also keep the training code but without training images set.



Testing_img=imread('training_images/train01.jpg');
[num_blue,num_red]= detect_lego(Testing_img)





