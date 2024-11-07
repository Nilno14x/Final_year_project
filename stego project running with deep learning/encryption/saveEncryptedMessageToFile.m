
function saveEncryptedMessageToFile(encryptedMessage)
    filename = 'D:\rsa_code\rsa_enc_dec.txt';
    dlmwrite(filename, encryptedMessage, 'delimiter', '\t');
    fprintf('\nEncrypted message saved to %s\n', filename);
end
