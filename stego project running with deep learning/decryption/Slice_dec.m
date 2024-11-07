%clc
%clear all
%close all

%addpath('decryption')
function Slice_dec(outputFilePath,output_text_File,key_file_path)

% Input and output file paths
%inputFilePath = 'cipher_text.txt';  % Replace with the actual input file path
%outputFilePath = 'output_text.txt';  % Replace with the desired output file path

% Read input from file
    CiphertextInput = fileread(outputFilePath);
    disp(length(CiphertextInput))

%Read Cipher input
    %CiphertextInput = ']bÄXÄJrå2ïTÇ¦]bÄ´ÄJrå2ïTÇ¦';
    
%Read Key
    %key = 'SecretChiliSauce';
    fileID = fopen(key_file_path,'r');
    key = fscanf(fileID,'%c',16);
    fclose(fileID);
    disp(key');
   
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
        result = [result, cipherText];
    end

% Calculate remainder
    %remainder = mod(length(CiphertextInput), 16);

% If there is a remainder, pad the last slice and call the cipher function
    %if remainder > 0
%        lastSliceText = [CiphertextInput((floorValue * 16) + 1:end), blanks(16 - remainder)];
%       lastCipherText = aes_decryption(lastSliceText, initial_roundkey, roundkeys);  
%       % Replace 'cipher' with your actual cipher function
%       result = [result, lastCipherText];
%   end

%remove padding
    %result = removePadding(result);
    
    fprintf('\nciphertext = \n');
    disp(result)
    disp(length(result))
    
% Save result to file
    fid = fopen(output_text_File, 'w');
    fprintf(fid, '%s\n', result);
    fclose(fid);
end