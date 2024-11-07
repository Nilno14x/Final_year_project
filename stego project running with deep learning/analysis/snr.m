%SNR
%original_image_path = 'F:\stego project running\img\alpine.png';
%stego_image_path = 'F:\stego project running\img\stegano.png';

% Read the original and stego images
originalImage = imread('F:\stego project running\img\camera.png');
distortedImage = imread('F:\stego project running\img\stegano.png');


% Read the original and the distorted images
%originalImage = imread('original_image.jpg'); % Replace 'original_image.jpg' with the filename of your original image
%distortedImage = imread('distorted_image.jpg'); % Replace 'distorted_image.jpg' with the filename of your distorted image

% Convert images to double for calculations
originalImage = double(originalImage);
distortedImage = double(distortedImage);

% Check if the image is RGB and convert to grayscale if needed
if size(originalImage, 3) == 3
    originalImage = rgb2gray(originalImage);
    distortedImage = rgb2gray(distortedImage);
end

% Calculate Signal Power (using mean squared intensity values)
signalPower = mean(originalImage(:).^2);

% Calculate Noise Power (using mean squared intensity values of the difference)
% Calculate Noise Power (using mean squared intensity values of the difference)
noise = originalImage - distortedImage;
epsilon = 1e-10; % Small constant to avoid division by zero
noisePower = mean(noise(:).^2) + epsilon;


% Calculate SNR in dB
snrValue = 10 * log10(signalPower / noisePower);

% Display the SNR value
fprintf('SNR: %.2f dB\n', snrValue);


