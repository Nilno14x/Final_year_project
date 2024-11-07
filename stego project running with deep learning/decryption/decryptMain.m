%clc
%clear all
%close all

function decryptMain()
    key_file_path = 'D:\stego project running\text\secret_key_dec.txt';
    
    % Decryption
    publicKey = input('Enter the public key (e) for decryption : ');
    privateKey = input('Enter the private key (d) for decryption : ');
    
    filename = 'D:\stego project running\text\rsa_enc_dec.txt';
    encryptedMessage = dlmread(filename, '\t');
    fprintf('\nEncrypted message loaded from %s\n', filename);

    % Decryption
    decryptedMessage = decryptMessage(publicKey, privateKey, encryptedMessage);

    fprintf('\nDecryption completed. \n Decrypted message is: %s\n', decryptedMessage);
    
    % Save result to file
    fid = fopen(key_file_path, 'w');
    fwrite(fid, decryptedMessage);
    fclose(fid);
end
