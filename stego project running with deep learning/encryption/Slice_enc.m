%clc
%clear all
%close all
%addpath('encryption')

function [result]= Slice_enc(inputFilePath,key_file_path)
% Input and output file paths
%inputFilePath = 'input_text.txt';  % Replace with the actual input file path
cipherFilePath = 'D:\Stego project running\text\cipher_enc_text.txt';  % Replace with the desired output file path

% Read input from file
    plaintextInput = fileread(inputFilePath);
    
    fprintf('\nplaintext = \n');
    disp(plaintextInput)
    disp(length(plaintextInput))
    
% Read input     
    %plaintextInput = 'ARandomPlainTex ARandomPlainText';
    
% Read key
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
    floorValue = floor(length(plaintextInput) / 16);

% Loop through the plaintext with step size of 16
    for i = 1:16:(floorValue * 16)
    % Slice plaintext
        slicetext = plaintextInput(i:i+15);

    % Call cipher function
        cipherText = aes_encryption(slicetext, initial_roundkey, roundkeys);
    %cipher(slice);  % Replace 'cipher' with your actual cipher function

    % Append to result
        result = [result, cipherText];
    end

% Calculate remainder
    remainder = mod(length(plaintextInput), 16);

% If there is a remainder, pad the last slice and call the cipher function
    if remainder > 0
        lastSliceText = [plaintextInput((floorValue * 16) + 1:end), blanks(16 - remainder)];
        lastCipherText = aes_encryption(lastSliceText, initial_roundkey, roundkeys);  
    % Replace 'cipher' with your actual cipher function
        result = [result, lastCipherText];
    end
    
    fprintf('\nciphertext = \n');
    disp(result)
    disp(length(result))
    
% Save result to file
    fid = fopen(cipherFilePath, 'w');
    fprintf(fid, '%s', result);
    fclose(fid);
end