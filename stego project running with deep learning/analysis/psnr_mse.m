% Read the original and stego images
original_image_path = 'F:\stego project running\img\Peppers-300x300.jpg';
stego_image_path = 'F:\stego project running\img\stegano.png';

% Read the original and stego images
original_img = imread(original_image_path);
stego_img = imread(stego_image_path);

% Convert images to double for calculations
original_img = double(original_img);
stego_img = double(stego_img);

% Ensure images have the same size
if ~isequal(size(original_img), size(stego_img))
     error('Images must have the same dimensions.');
end

% Calculate Mean Squared Error (MSE)
mse_value = sum((original_img(:) - stego_img(:)).^2) / numel(original_img);

% Calculate Peak Signal-to-Noise Ratio (PSNR)
max_pixel_value = max(original_img(:));
psnr_value = 10 * log10((max_pixel_value^2) / mse_value);

% Display the results
fprintf('MSE Value: %.4f\n', mse_value);
fprintf('PSNR Value: %.4f dB\n', psnr_value);

% Calculate SSIM
ssim_value = ssim(original_img, stego_img);

% Display the result
fprintf('SSIM Value: %.4f\n', ssim_value);