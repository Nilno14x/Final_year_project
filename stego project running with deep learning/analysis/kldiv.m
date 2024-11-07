% Read the images
img1 = imread('F:\stego project running\img\F-16_512-512.jpg');
img2 = imread('F:\stego project running\img\stegano.jpg');



% Convert images to grayscale if they are not already
if size(img1, 3) == 3
    img1 = rgb2gray(img1);
end
if size(img2, 3) == 3
    img2 = rgb2gray(img2);
end

% Calculate the histograms of the images
hist1 = imhist(img1);
hist2 = imhist(img2);

% Normalize the histograms to create probability distributions
probDist1 = hist1 / sum(hist1);
probDist2 = hist2 / sum(hist2);

% Calculate the KL divergence with a small constant to avoid division by zero
klDiv = sum(probDist1 .* log2((probDist1 + eps) ./ (probDist2 + eps)));

% Output the KL divergence
disp(['The KL divergence between the images is ', num2str(klDiv)])

% Check if the images are similar based on a threshold value
threshold = 0.1;  % Adjust this value based on your specific use case
if klDiv < threshold
    disp('The images are similar.')
else
    disp('The images are not similar.')
end

