function embed_demo(input_image_path, output_image_path)
    ciphertextFilePath = 'F:\stego project running\text\cipher_text.txt';
    file_name = 'F:\stego project running\text\bin.txt';
    
    % Read image (carrier)
    image = imread(input_image_path);

    % Read text
    fileID = fopen(ciphertextFilePath, 'rt');
    message = fread(fileID);
    fclose(fileID);

    disp('Message:');
    disp(message);
    
    bin_text = de2bi(message, 8);
    
    fileID = fopen(file_name, 'w');
    % Write binary data to the file
    fprintf(fileID, '%d', bin_text);

    % Close the file
    fclose(fileID);
    
    [char_count, ~] = size(bin_text);

    % convert to YCbCr color space
    image_ycbcr = rgb2ycbcr(image);

    % extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);

    % construct Haar wavelet
    haar_wavelet = liftwave('haar', 'Int2Int');

    % apply DWT to the input image, on Cb channel
    % L/H = Low/High
    % LL = approximation coefficients
    % HL/LH/HH = detail coefficients
    [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

    % Hide text in HH and HL regions
    [~, HH_width] = size(HH);
    [~, HL_width] = size(HL);
    [~, LH_width] = size(LH);
    [~, LL_width] = size(LL);
    % Flatten the wavelet coefficients
    HH_flat = reshape(HH.', 1, []);
    HL_flat = reshape(HL.', 1, []);
    LH_flat = reshape(LH.', 1, []);
    LL_flat = reshape(LL.', 1, []);
    
    size_length = 4;
    overwhelmed = (8 * char_count + 8 * size_length) > (length(HH_flat) + length(HL_flat) + length(LH_flat) + length(LL_flat));
    
    if (overwhelmed)
        disp('Text length is too large to be embedded!');
    else
        % Store the number of chars as the first `size_length` bytes
        HH_flat(1:size_length * 8) = de2bi(char_count, size_length * 8);

        % Calculate limits for embedding in HH
        HH_can_fit = length(HH_flat) / 8;
        HH_limit = min(char_count + size_length, HH_can_fit);

        % Encode in HH (first 2 bytes = size)
        for i = size_length + 1:HH_limit
            HH_flat((i-1)*8 + 1:(i-1)*8 + 8) = bin_text(i-size_length, :);
        end

        % If HH can't contain all, also use HL
        rest = char_count + size_length - HH_can_fit;
        if (rest > 0)
            % Embed in HL
            HL_flat(1:rest * 8) = bin_text(HH_limit-size_length+1:HH_limit, :);

            % If HL can't contain all, also use LH
            rest = rest - length(HL_flat) / 8;
            if (rest > 0)
                % Embed in LH
                LH_flat(1:rest * 8) = bin_text(HH_limit-size_length+HH_can_fit+1:HH_limit-size_length+HH_can_fit+rest, :);

                % If LH can't contain all, also use LL
                rest = rest - length(LH_flat) / 8;
                if (rest > 0)
                    LL_flat(1:rest * 8) = bin_text(HH_limit-size_length+HH_can_fit+HH_can_fit+1:HH_limit-size_length+HH_can_fit+HH_can_fit+rest, :);
                end
            end
        end
    end

    % Restore matrix dimensions
    HH = vec2mat(HH_flat, HH_width);
    HL = vec2mat(HL_flat, HL_width);
    LH = vec2mat(LH_flat, LH_width);
    LL = vec2mat(LL_flat, LL_width);  % Add this line to restore LL dimensions

    % Output final image
    image_ycbcr(:, :, 2) = ilwt2(LL, HL, LH, HH, haar_wavelet);
    out_image = ycbcr2rgb(image_ycbcr);
    imwrite(out_image, output_image_path);

    % Display the steganographic image
    figure;
    imshow(out_image);
    title('Stegano Image');
    disp('Embedding done');
end

