function generateHexKey()
    key_file_path = 'D:\stego project running\text\secret_key.txt';
    key = '';
    for i = 1:16
        % Generate a random hexadecimal character (0-9, A-F)
        hexChar = dec2hex(randi([0, 15], 1, 1), 1);

        % Append the generated character to the key
        key = [key, hexChar];
    end
    % Save result to file
    fileid = fopen(key_file_path, 'w');
    fprintf(fileid,key);
    fclose(fileid);
    
end
