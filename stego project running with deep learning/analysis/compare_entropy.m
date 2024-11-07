function compare_entropy(original_image, stego_image)
    % Calculate the entropy of the original image
    original_entropy = calculate_entropy(original_image);
    fprintf('The entropy of the original image is: %f\n', original_entropy);

    % Calculate the entropy of the stego image
    stego_entropy = calculate_entropy(stego_image);
    fprintf('The entropy of the stego image is: %f\n', stego_entropy);

    % Compare the entropy values
    if abs(original_entropy - stego_entropy) < 0.01
        disp('The entropy of the original image and the stego image are approximately the same. The steganography technique used might be very effective.')
    else
        disp('The entropy of the original image and the stego image are significantly different. The steganography technique used might have caused detectable changes in the image.')
    end
end


