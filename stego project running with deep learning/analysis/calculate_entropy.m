function entropy = calculate_entropy(image)
    % Convert the image to grayscale if it is not
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % Calculate the histogram of the grayscale image
    histogram = imhist(image);

    % Normalize the histogram
    normalized_histogram = histogram / numel(image);

    % Calculate the entropy
    entropy = -sum(normalized_histogram .* log2(normalized_histogram + eps));
end