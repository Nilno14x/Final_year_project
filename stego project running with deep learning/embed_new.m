function embed_new(input_image_path, output_image_path)
    ciphertextFilePath = 'D:\Stego project running\text\cipher_text.txt';
    file_name = 'D:\Stego project running\text\bin.txt';
    
    % Read image (carrier)
    image = imread(input_image_path);

    % Read text
    fileID = fopen(ciphertextFilePath, 'rt');
    message = fread(fileID);
    fclose(fileID);

    disp('Message:');
    disp(message);
    
    bin_text = de2bi(message,8);
    
    fileID = fopen(file_name, 'w');
    % Write binary data to the file
    fprintf(fileID, '%d', bin_text);

    % Close the file
    fclose(fileID);
    
    [char_count, ~] = size(bin_text);

    if size(image,3) == 3
    
        % convert to YCbCr color space
        image_ycbcr = rgb2ycbcr(image);

        % extract blue-difference chroma
        cb = image_ycbcr(:, :, 2);

        % construct Haar wavelet
        haar_wavelet = liftwave('haar', 'Int2Int');

        [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

        % Hide text in HH and HL regions
        [~, HH_width] = size(HH);
        [~, HL_width] = size(HL);

        HH_flat = reshape(HH.', 1, []);
        HL_flat = reshape(HL.', 1, []);
    else
        haar_wavelet = liftwave('haar', 'Int2Int');

        [LL, HL, LH, HH] = lwt2(double(image), haar_wavelet);
    
        % Hide text in HH and HL regions
        [~, HH_width] = size(HH);
        [~, HL_width] = size(HL);
        
        % Define LL for the grayscale image case
        %LL = zeros(size(HL));
        %LH=zeros(size(HH));
        
        HH_flat = reshape(HH.', 1, []);
        HL_flat = reshape(HL.', 1, []);
    
        % Normalize pixel values within the range of HH and HL
        scale_HH = max(abs(HH_flat(:)))/255;
        scale_HL = max(abs(HL_flat(:)))/255;

        HH_flat = uint8(HH_flat / scale_HH);
        HL_flat = uint8(HL_flat / scale_HL); 
    
        disp('b&W');
    end
    
    size_length = 4;
    overwhelmed = (8 * char_count + 8 * size_length) > (length(HH_flat) + length(HL_flat));
    
    
    if (overwhelmed)
        disp('Text length is too large to be embedded!');
    else
        % store the number of chars as the first `size_length` bytes
        
        HH_flat(1:size_length * 8) = de2bi(char_count, size_length * 8);

        HH_can_fit = length(HH_flat) / 8;

        HH_limit = min(char_count + size_length, HH_can_fit);

        % encode in HH (first 2 bytes = size)
        for i = size_length + 1:HH_limit
            HH_flat((i-1)*8 + 1:(i-1)*8 + 8) = bin_text(i-size_length, :);
        end

        % if HH can't contain all, also use HL
        rest = char_count + size_length - HH_can_fit;
        if (rest > 0)
            for i = 1:rest
                HL_flat((i-1)*8+1:(i-1)*8+8) = bin_text(i-size_length+HH_limit, :);
            end
        end
    end

    if size(image,3) == 3
        % restore matrix dimensions
        HH = vec2mat(HH_flat, HH_width);
        HL = vec2mat(HL_flat, HL_width);
    
        image_ycbcr(:, :, 2) = ilwt2(LL, HL, LH, HH, haar_wavelet);
        out_image = ycbcr2rgb(image_ycbcr);
        
        imwrite(out_image, output_image_path);
    else
        % restore matrix dimensions
        HH = vec2mat(double(HH_flat), HH_width);
        HL = vec2mat(double(HL_flat), HL_width);
    
        out_image(:,:) = ilwt2(LL, HL, LH, HH, haar_wavelet);
    
        out_image = uint8(max(0, min(255, out_image)));
        %out_image=rgb2grey(out_image);
        imwrite(out_image, output_image_path);
    end
    
    output_image_path1 ='E:\text-in-image\stegano.png';
    imwrite(out_image, output_image_path1);
    figure;
    imshow(out_image);
    title('Stegano Image');
    disp('Embedding done');
end
