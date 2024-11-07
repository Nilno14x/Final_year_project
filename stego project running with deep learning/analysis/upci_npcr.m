% Read the original and stego images
original_image_path = 'F:\stego project running\img\stegano_bob3.png';
stego_image_path = 'F:\stego project running\img\stegano_bob4.png';

original = imread(original_image_path);
stego = imread(stego_image_path);

% Ensure the images are of the same size
if size(original) ~= size(stego)
    error('Images must be of the same size');
end

% Calculate the difference image
diff = original ~= stego;

% Calculate NPCR
npcr = sum(diff(:)) / numel(original) ;

% Calculate UACI
uaci = sum(abs(double(original(:)) - double(stego(:)))) / (255 * numel(original)) ;

% Print the NPCR and UACI
fprintf('NPCR: %f %\n', npcr);
fprintf('UACI: %f %\n', uaci);