function extract_new_1(input_image_path)
    file_name = 'D:\Stego project running\text\extract_bin.txt';
    dec_file_name = 'D:\Stego project running\text\convert_dec.txt';
    % Read image (carrier)
    image = imread(input_image_path);

    if size(image,3) == 3
        % convert to YCbCr color space
        image_ycbcr = rgb2ycbcr(image);

        % extract blue-difference chroma
        cb = image_ycbcr(:, :, 2);

        % construct Haar wavelet
        haar_wavelet = liftwave('haar', 'Int2Int');

        [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

        % Extract text from HH and HL regions
        HH_flat = reshape(HH.', 1, []);
        HL_flat = reshape(HL.', 1, []);
        LH_flat = reshape(LH.', 1, []);
    else
        haar_wavelet = liftwave('haar', 'Int2Int');

        [LL, HL, LH, HH] = lwt2(double(image), haar_wavelet);
    
        % Extract text from HH and HL regions
        HH_flat = reshape(HH.', 1, []);
        HL_flat = reshape(HL.', 1, []);
        LH_flat = reshape(LH.', 1, []);
    end

    size_length = 4;
    
    % Check if HH_flat contains only binary values
    if any(HH_flat > 1)
        disp('Error: HH_flat contains non-binary values.');
        %return;
    end

    % Check if the slice operation produces the expected result
    slice = HH_flat(1:size_length * 8);
    if length(slice) ~= size_length * 8
        disp('Error: Slice operation did not produce the expected result.');
        %return;
    end
    disp(slice)
    % Convert binary to decimal
    char_count = bi2de(slice);

    disp('Message length:');
    disp(char_count);

    % Continue with the rest of your code...
    bin_text = zeros(char_count, 8);
    
    HH_can_fit = length(HH_flat) / 8;
    HH_limit = min(char_count + size_length, HH_can_fit);    
    
    for i = size_length + 1:HH_limit
        bin_text(i-size_length, :) = abs(HH_flat((i-1)*8 + 1:(i-1)*8 + 8));
    end

    % if HH can't contain all, also use HL
    rest = char_count + size_length - HH_can_fit;
    if (rest > 0)
        for i = 1:rest
            bin_text(i-size_length+HH_limit, :) = abs(HL_flat((i-1)*8+1:(i-1)*8+8));
        end
    end

    % if HL can't contain all, also use LH
    rest = rest - length(HL_flat) / 8;
    if (rest > 0)
        for i = 1:rest
            bin_text(i-size_length+HH_limit+length(HL_flat)/8, :) = abs(LH_flat((i-1)*8+1:(i-1)*8+8));
        end
    end

    % if LH can't contain all, also use LL
    rest = rest - length(LH_flat) / 8;
    if (rest > 0)
        for i = 1:rest
            bin_text(i-size_length+HH_limit+length(HL_flat)/8+length(LH_flat)/8, :) = abs(LL_flat((i-1)*8+1:(i-1)*8+8));
        end
    end

    %message = bi2de(bin_text);
    %disp('Message:');
    %disp(message);

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