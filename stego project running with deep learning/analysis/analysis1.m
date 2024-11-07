% Read the original and distorted images
%originalImage = imread('F:\stego project running\img\alpine.png');
%distortedImage = imread('F:\stego project running\img\stegano.png');
originalImage = 'E:\stego project running\img\lena.png';
distortedImage = 'E:\stego project running\img\stegano.png';

% Convert images to double and normalize pixel values to the range [0, 1]
originalImage = double(originalImage) / 255.0;
distortedImage = double(distortedImage) / 255.0;

% Calculate NPCR (Normalized Pixel Change Rate)
numPixels = numel(originalImage);
npcrValue = sum(sum(originalImage ~= distortedImage)) / numPixels ;

% Calculate MCI (Mean Color Intensity)
mciValue = mean2(abs(originalImage - distortedImage));

% Calculate Entropy
entropyOriginal = entropy(originalImage);
entropyDistorted = entropy(distortedImage);
entropyValue = entropyDistorted - entropyOriginal;

% Display the results
%fprintf('NPCR: %.4f\n', npcrValue);
%fprintf('MCI: %.4f\n', mciValue);
fprintf('Entropy: %.4f\n', entropyValue);
