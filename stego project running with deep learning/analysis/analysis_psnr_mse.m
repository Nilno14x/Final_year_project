% Read in the first image from a .png file
imagePath1 = 'E:\stego project\img\alpine.png';  % Replace with your first image file path
originalImage1 = imread(imagePath1);

% Convert to grayscale if the image is colorful
if size(originalImage1, 3) == 3
    grayImage1 = rgb2gray(originalImage1);
else
    grayImage1 = originalImage1;
end

% Read in the second image from a .png file
imagePath2 = 'E:\stego project\img\stegano.png';  % Replace with your second image file path
originalImage2 = imread(imagePath2);

% Convert to grayscale if the image is colorful
if size(originalImage2, 3) == 3
    grayImage2 = rgb2gray(originalImage2);
else
    grayImage2 = originalImage2;
end

% Check if images have the same size
if ~isequal(size(grayImage1), size(grayImage2))
    error('Images must have the same dimensions for PSNR comparison.');
end

% Calculate mean square error.
mseImage = (double(grayImage1) - double(grayImage2)) .^ 2;
mse = sum(mseImage(:)) / numel(grayImage1);

% Calculate PSNR (Peak Signal to noise ratio).
if mse == 0
    PSNR = Inf;
else
    PSNR = 10 * log10(255^2 / mse);
end

fprintf('The mean square error is %.2f\n', mse);
fprintf('The PSNR value is %.2f dB\n', PSNR);


