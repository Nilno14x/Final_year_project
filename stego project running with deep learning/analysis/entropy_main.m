%%%ENTROPY calculate

%original_image='F:\stego project running\img\camera.png';
%stego_image='F:\stego project running\img\stegano.png';

%original_image=imread(original_image);
%stego_image=imread(stego_image);
%entropy=calculate_entropy(original_image);

%disp('entropy original image:');
%disp(entropy);

%compare_entropy(original_image, stego_image);
%disp('entropy original image vs stego image:');
%disp(coen);




% Read the RGB image
rgb_image = imread('E:\stego project running\img\lena.png');

% Convert the RGB image to grayscale
%grayscale_image = rgb2gray(rgb_image);

grayscale_image=imread('E:\stego project running\img\stegano.png');
% Display the grayscale image
imshow(grayscale_image);

J = entropy(grayscale_image);
disp(J);