function histogramAnalysis(image_path)
    % Read the image
    img = imread(image_path);

    % Display the original image
    figure;
    subplot(2, 2, 1);
    imshow(img);
    title('Original Image');

    % Convert the image to grayscale if it's RGB
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end

    % Display the grayscale image
    subplot(2, 2, 2);
    imshow(img_gray);
    title('Grayscale Image');

    % Calculate and plot the histogram
    subplot(2, 2, [3, 4]);
    imhist(img_gray);
    title('Histogram');

    % Customize the histogram plot
    xlabel('Pixel Intensity');
    ylabel('Frequency');
    xlim([0, 256]); % Adjust the x-axis limit based on image bit depth

    % Display grid on the histogram plot
    grid on;
end


