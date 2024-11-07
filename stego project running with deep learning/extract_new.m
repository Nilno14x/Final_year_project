function extract_new(input_image_path)
    file_name = 'D:\Stego project running\text\extract_bin.txt';
    dec_file_name = 'D:\Stego project running\text\convert_dec.txt';
    % Read stego image
    stego_image = imread(input_image_path);

    if size(stego_image,3) == 3
        % convert to YCbCr color space
        image_ycbcr = rgb2ycbcr(stego_image);

        % extract blue-difference chroma
        cb = image_ycbcr(:, :, 2);

        % construct Haar wavelet
        haar_wavelet = liftwave('haar', 'Int2Int');
    
        [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);
    else
        haar_wavelet = liftwave('haar', 'Int2Int');
    
        [LL, HL, LH, HH] = lwt2(double(stego_image), haar_wavelet);
    end

    % Read from HH and HL regions
    HH_flat = reshape(HH.', 1, []);
    HL_flat = reshape(HL.', 1, []);

    % Read the size information from the first `size_length` bytes in HH
    size_length = 4;
    char_count = bi2de(HH_flat(1:size_length * 8));

    bin_text = zeros(char_count, 8);

    HH_can_fit = length(HH_flat) / 8;
    HH_limit = min(char_count + size_length, HH_can_fit);

    % Read from HH
    for i = size_length + 1:HH_limit
        bin_text(i-size_length, :) = abs(HH_flat((i-1)*8+1:(i-1)*8+8));
    end

    % If HH couldn't contain the entire text, also read from HL
    rest = char_count + size_length - HH_can_fit;
    if (rest > 0)
        for i = HH_limit + 1:min(HH_limit + rest, length(HL_flat) / 8)
            bin_text(i-size_length, :) = abs(HL_flat((i-HH_limit-1)*8+1:(i-HH_limit-1)*8+8));
        end
    end
    
    fileID = fopen(file_name, 'w');
    % Write binary data to the file
    fprintf(fileID, '%d', bin_text);

    % Close the file
    fclose(fileID);
    % Convert text from binary to decimal
    dec_text = bi2de(bin_text);
    char_text = char(dec_text);
    % Convert decimal to ASCII characters
    %extracted_message = char(dec_text)';
        
    
    fileID = fopen(dec_file_name, 'w');
    % Write binary data to the file
    fwrite(fileID, char_text);
    % Close the file
    fclose(fileID);
    disp('Extracted Message:');
    disp(char_text);
    disp('extraction done');
end
