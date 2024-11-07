
% Read the images
img1 = imread('F:\stego project running\img\F-16_512-512.png');
img2 = imread('F:\stego project running\img\stegano.png');

 [height, width, ~] = size(img1);  % Assuming third dimension is for color channels
 value = 0;
 for y = 1:height
    for x = 1:width
        for c = 1:size(img1, 3)
             value = value + abs(double(img1(y, x, c)) - double(img2(y, x, c)));
        end
    end
 end
 value = value * 100 / (width * height * size(img1, 3) * 255);
 uaci_value = value;

% Display UACI value

fprintf('UACI: %.4f\n', uaci_value);

    % Ensure images have the same size
    if ~isequal(size(img1), size(img2))
        error('Images must have the same dimensions.');
    end

    % Calculate NPCR
    num_pixels_changed = nnz(img1 ~= img2);
    npcr_value = num_pixels_changed / numel(img1);

% Display NPCR value

fprintf('NPCR: %.4f\n', npcr_value);


