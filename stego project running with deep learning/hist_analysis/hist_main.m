% Specify the path to your image
%image_path = 'F:\stego project running\img\F-16_512-512.png';

% Call the histogramAnalysis function
%histogramAnalysis(image_path);

%histogram analysis of stego image and original image
% Specify the paths to your images
original_image_path = 'E:\stego project running\img\lena.png';
stego_image_path = 'E:\stego project running\img\stegano.png';

% Call the compareHistograms function
compareHistograms(original_image_path, stego_image_path);