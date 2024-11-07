% Read the two images
image1 = imread('E:\stego project running\img\lena.png');
image2 = imread('E:\stego project running\img\stegano.png');

% Convert images to grayscale
image1_gray = rgb2gray(image1);
image2_gray = rgb2gray(image2);

% Convert images to double for calculations
image1_double = double(image1_gray) / 255.0;
image2_double = double(image2_gray) / 255.0;

% Calculate Pearson's correlation coefficient
correlationCoefficient = corr2(image1_double, image2_double);

% Display the result
fprintf('Pearson''s Correlation Coefficient: %.4f\n', correlationCoefficient);
