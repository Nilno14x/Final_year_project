function compareHistograms(original_image_path, stego_image_path)
    % Read the original and stego images
    original_img = imread(original_image_path);
    stego_img = imread(stego_image_path);

    % Convert images to grayscale if they are RGB
    if size(original_img, 3) == 3
        original_img_gray = rgb2gray(original_img);
    else
        original_img_gray = original_img;
    end

    if size(stego_img, 3) == 3
        stego_img_gray = rgb2gray(stego_img);
    else
        stego_img_gray = stego_img;
    end

    % Display the original and stego images
    figure;
    
    subplot(2, 2, 1);
    imshow(original_img);
    title('Original Image');

    subplot(2, 2, 2);
    imshow(original_img_gray);
    title('Original Grayscale Image');

    subplot(2, 2, 3);
    imshow(stego_img);
    title('Stego Image');

    subplot(2, 2, 4);
    imshow(stego_img_gray);
    title('Stego Grayscale Image');

    % Display histograms for the original and stego images
    figure;

    subplot(2, 1, 1);
    pixel_values_original = original_img_gray(:);
    plot(sort(pixel_values_original), linspace(0, 1, numel(pixel_values_original)), 'b-', 'LineWidth', 2);
    title('Histogram - Original Image');
    xlabel('Pixel Intensity');
    ylabel('Cumulative Probability');
    xlim([0, 256]);
    grid on;

    subplot(2, 1, 2);
    pixel_values_stego = stego_img_gray(:);
    plot(sort(pixel_values_stego), linspace(0, 1, numel(pixel_values_stego)), 'r-', 'LineWidth', 2);
    title('Histogram - Stego Image');
    xlabel('Pixel Intensity');
    ylabel('Cumulative Probability');
    xlim([0, 256]);
    grid on;
end
