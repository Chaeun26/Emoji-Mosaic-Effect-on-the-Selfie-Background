
% load images
img = imread('selfie16.png');
RGBImg = imread('selfie16.png');

% image preprocessing - lower brightness to bright part
img = image_preprocessing(img);
% find edges with Laplacian of Gaussian
result = LoG_edge_detect(img);
% show the process - edge detection
figure; imshow(result);
% using dilation & imfill function to get the region of foreground
result = morphological_improvement(result);
% segmentation of foreground and background
[background, foreground] = foreground_background_segmentation(result, RGBImg);

imwrite(uint8(background),"background.png");
imwrite(uint8(foreground),"foreground.png");

figure; imshow(uint8(background));
figure; imshow(uint8(foreground));