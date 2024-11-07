function reverseProcessTextFile()
    % Input and output file paths
    %inputFilePath = 'cipher_text.txt';  % Replace with the actual input file path
    output_text_File = 'D:\stego project running\text\output_text.txt';  % Replace with the desired output file path
    secret_message_path='D:\stego project running\text\convert_dec.txt';
    key_file_path = 'D:\stego project running\text\secret_key_dec.txt';
    
    % Read input from file
    fileID = fopen(secret_message_path,'r');
    CiphertextInput = fread(fileID,'*char');
    fclose(fileID);
    disp('ciphertext input:');
    disp(CiphertextInput')
    disp(length(CiphertextInput));
    
    %read the key
    fileID = fopen(key_file_path,'r');
    key = fscanf(fileID,'%c',16);
    fclose(fileID);
    disp(key);
    
    %Read Cipher input
    %CiphertextInput = ']bÄXÄJrå2ïTÇ¦]bÄ´ÄJrå2ïTÇ¦';
    
    %Read Key
    %key = 'SecretChiliSauce';
    
    % generate round keys
    [initial_roundkey, roundkeys] = gen_round_keys(key);
    
    % Initialize result
    result = '';

    % Calculate floor value
    floorValue = floor(length(CiphertextInput) / 16);

    % Loop through the plaintext with step size of 16
    for i = 1:16:(floorValue * 16)
        % Slice plaintext
        slicetext = CiphertextInput(i:i+15);

        % Call cipher function
        cipherText = aes_decryption(slicetext, initial_roundkey, roundkeys);
        %cipher(slice);  % Replace 'cipher' with your actual cipher function

        % Append to result
        result = [result cipherText];
    end

    % Remove padding if necessary
    result = removePadding(result);

    
    fprintf('\ndeciphertext = \n');
    disp(result)
    disp(length(result))
    
    % Save result to file
    fid = fopen(output_text_File, 'w');
    fwrite(fid, result);
    fclose(fid);
    disp('decipher done');
end