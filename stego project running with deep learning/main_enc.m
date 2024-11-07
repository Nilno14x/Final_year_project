addpath('encryption');
addpath('deep');

input_image_file='D:\stego project running\img\64\alpine_64.png';
output_stego_image='D:\stego project running\img\stegano_n.png';

input_text_file='D:\stego project running\text\msg\test1.txt';
%secret_key_file='D:\stego project running\text\secret_key.txt';

%ciphered_text_file='D:\stego project running\text\cipher_text.txt';
%ciphered_text_to_bin_file='D:\stego project running\text\bin.txt';

%extracted_bin_file='D:\stego project running\text\extract_bin.txt';
%extract_bin_to_text_file='D:\stego project running\text\convert_dec.txt';

%deciphered_file='D:\stego project running\text\output_text.txt';

Slice_concate_enc(input_text_file);

embed_new(input_image_file,output_stego_image);

encryptMessage();
