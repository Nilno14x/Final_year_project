function histogram = calculate_histogram(image)
    % Convert the image to grayscale if it's in color
    if size(image, 3) == 3
        gray_image = rgb2gray(image);
    else
        gray_image = image;
    end

    % Calculate histogram
    histogram = imhist(gray_image) / numel(gray_image);
end