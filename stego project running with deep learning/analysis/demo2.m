% Read the image
img = imread('F:\stego project running\img\alpine.png');

% Check if the image is grayscale or color
[rows, cols, numColorChannels] = size(img);

% Alter one pixel
% For grayscale image
if numColorChannels == 1
    img(1,1) = 0; % Change the pixel at (1,1) to black
% For color image
else
    img(1,1,:) = [0 0 0]; % Change the pixel at (1,1) to black
end

% Save the image
imwrite(img, 'F:\stego project running\img\altered_image.png');
