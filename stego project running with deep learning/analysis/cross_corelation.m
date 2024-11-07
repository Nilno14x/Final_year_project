% Cross-correlation

image1_path = 'E:\stego project running\img\lena.png';
image2_path = 'E:\stego project running\img\stegano.png';

% Read the images
image1 = imread(image1_path);
image2 = imread(image2_path);

% Convert images to grayscale if they are RGB
if size(image1, 3) == 3
    image1 = rgb2gray(image1);
end

if size(image2, 3) == 3
    image2 = rgb2gray(image2);
end

% Compute cross-correlation
cross_correlation = xcorr2(image1, image2);

% Find the peak value and its location
[maxValue, maxIndex] = max(cross_correlation(:));
[row, col] = ind2sub(size(cross_correlation), maxIndex);

% Display the result
figure;
subplot(1, 3, 1); imshow(image1); title('Image 1');
subplot(1, 3, 2); imshow(image2); title('Image 2');
subplot(1, 3, 3); imagesc(cross_correlation); title('Cross-Correlation');

colormap('jet');
colorbar;

fprintf('Maximum Cross-Correlation Value: %f\n', maxValue);
fprintf('Location of Maximum Cross-Correlation: (%d, %d)\n', row, col);
