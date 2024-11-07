function npcr_uaci_main()
    % Replace these paths with your actual image paths
    original_image_path = 'F:\stego project running\img\stegano_bob1.png';
    encrypted_image_path = 'F:\stego project running\img\stegano_bob2.png';

    % Read images
    original_image = imread(original_image_path);
    encrypted_image = imread(encrypted_image_path);

    % Check if the images have the same size
    if size(original_image) ~= size(encrypted_image)
        error('Images must have the same size');
    end

    % Convert images to grayscale if they are RGB
    if size(original_image, 3) == 3
        original_image = rgb2gray(original_image);
        encrypted_image = rgb2gray(encrypted_image);
    end

    % Normalize images to the range [0, 255]
    original_image = double(original_image);
    encrypted_image = double(encrypted_image);

    % Calculate NPCR
    npcr_result = Cal_NPCR(original_image, encrypted_image);
    disp(['NPCR: ', num2str(npcr_result), '%']);

    % Calculate UACI
    uaci_result = UACI(original_image, encrypted_image);
    disp(['UACI: ', num2str(uaci_result), '%']);
end
