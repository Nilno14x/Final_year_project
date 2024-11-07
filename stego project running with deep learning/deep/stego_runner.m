% Define file paths
cover_image_path = 'D:\stego project running\img\64\lady_64.png';
secret_image_path = 'D:\stego project running\img\stegano_n.png';

stego_image_path = 'D:\stego project running\img\stego.png';
decoded_secret_image_path = 'D:\stego project running\img\decoded_stego.png';

model_path = 'D:\stego project running\deep\model_deep_steg.h5';
python_script_path = 'D:\stego project running\deep\stego_final.py';

% Call the Python script
system(sprintf('python "%s" "%s" "%s" "%s" "%s" "%s"', ...
    python_script_path, model_path, cover_image_path, secret_image_path, stego_image_path, decoded_secret_image_path));

% Read the images
cover_img = imread(cover_image_path);
secret_img = imread(secret_image_path);
stego_img = imread(stego_image_path);
decoded_secret_img = imread(decoded_secret_image_path);

% Display the images
figure;

subplot(1, 4, 1);
imshow(cover_img);
title('Cover Image');

subplot(1, 4, 2);
imshow(secret_img);
title('Secret Image');

subplot(1, 4, 3);
imshow(stego_img);
title('Stego Image');

subplot(1, 4, 4);
imshow(decoded_secret_img);
title('Decoded Secret Image');
