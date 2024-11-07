function npcr_value = calculate_npcr(cover_image, stego_image)
    % Ensure the images have the same dimensions
    if ~isequal(size(cover_image), size(stego_image))
        error('Cover and stego images must have the same dimensions.');
    end

    % Convert the images to uint8 format
    cover_image = uint8(cover_image);
    stego_image = uint8(stego_image);

    % Calculate the NPCR
    num_changed_pixels = nnz(cover_image ~= stego_image);
    total_pixels = numel(cover_image);
    npcr_value = (num_changed_pixels / total_pixels) * 100;
end