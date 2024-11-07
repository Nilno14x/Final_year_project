addpath('decryption');
addpath('deep');    

% input_image_file='D:\stego project running\img\alpine.png';
%input_text_file='D:\stego project running\text\lorem-ipsum.txt';

output_stego_image='D:\stego project running\img\decoded_stego.png';
secret_key_file='D:\stego project running\text\secret_key_dec.txt';
   
%ciphered_text_file='D:\stego project running\text\cipher_text.txt';
%ciphered_text_to_bin_file='D:\stego project running\text\bin.txt';

%extracted_bin_file='D:\stego project running\text\extract_bin.txt';
%extract_bin_to_text_file='D:\stego project running\text\convert_dec.txt';

%deciphered_file='D:\stego project running\text\output_text.txt';

extract_new_1(output_stego_image);

decryptMain();

%reverseProcessTextFile(secret_message_path,output_text_File)
reverseProcessTextFile();

