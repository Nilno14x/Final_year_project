% Specify the paths of the text files
file1_path = 'F:\stego project running\text\lorem-ipsum.txt';
file2_path = 'F:\stego project running\text\output_text.txt';

% Read the files
fileID1 = fopen('F:\stego project running\text\lorem-ipsum.txt','r');
file1 = fscanf(fileID1,'%c');
fclose(fileID1);

fileID2 = fopen('F:\stego project running\text\output_text.txt','r');
file2 = fscanf(fileID2,'%c');
fclose(fileID2);

% Convert characters to ASCII values
ascii1 = double(file1);
ascii2 = double(file2);

% Make the vectors the same length
minLength = min(length(ascii1), length(ascii2));
ascii1 = ascii1(1:minLength);
ascii2 = ascii2(1:minLength);

% Calculate Pearson correlation
corrCoeff = corrcoef(ascii1, ascii2);

% Output the correlation coefficient as a measure of similarity
disp(['The similarity between the files is ', num2str(corrCoeff(1,2))])
