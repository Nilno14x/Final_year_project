function uaci_value = calculate_uaci(cover_image, stego_image)
    % Ensure the images have the same dimensions
    if ~isequal(size(cover_image), size(stego_image))
        error('Cover and stego images must have the same dimensions.');
    end

    % Convert the images to double format
    cover_image = double(cover_image);
    stego_image = double(stego_image);

    % Calculate the UACI
    intensity_diff = abs(cover_image - stego_image);
    uaci_value = mean(intensity_diff(:));
end