% Original text
originalText = 'E:\stego project running\text\lorem-ipsum.txt';
ciphered_text_file='E:\stego project running\text\cipher_text.txt';

fileID = fopen(originalText, 'rt');
    message1 = fread(fileID);
    fclose(fileID);
    
fileID = fopen(ciphered_text_file, 'rt');
message2 = fread(fileID);
fclose(fileID);    
% Encrypt the text using a simple algorithm (replace with your encryption method)
%encryptedText = encryptFunction(originalText);

% Convert text to numerical data for correlation analysis
originalNumeric = double(message1);
encryptedNumeric = double(message2);

% Calculate correlation coefficient
correlationCoefficient = corrcoef(originalNumeric, encryptedNumeric);

% Display correlation coefficient
disp(['Correlation Coefficient: ' num2str(correlationCoefficient(1, 2))]);

% Create histograms
figure;

subplot(2, 1, 1);
hist(originalNumeric, 50);
title('Original Text');
xlabel('Character Value');
ylabel('Frequency');

subplot(2, 1, 2);
hist(encryptedNumeric, 50);
title('Encrypted Text');
xlabel('Character Value');
ylabel('Frequency');
