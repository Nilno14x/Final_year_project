% Get the file names or use default names
%file1 = 'F:\stego project\text\bin.txt';  % Replace with the actual file name
%file2 = 'F:\stego project\text\extract_bin.txt';  % Replace with the actual file name

file1 = 'E:\stego project\text\hello.txt';  % Replace with the actual file name
file2 = 'E:\stego project\text\output_text.txt';

% Read the contents of the files
try
    content1 = fileread(file1);
    content2 = fileread(file2);
catch
    error('Error reading files. Make sure the file names are correct and the files exist.');
end

disp('length ori file');
disp(length(file1));
disp('length decip file');
disp(length(file2));
% Compare the lengths of the files
if length(content1) == length(content2)
    disp('The lengths of the files are equal.');
    
    % Compare each character
    if isequal(content1, content2)
        disp('Every character in the files is equal.');
    else
        disp('Not every character in the files is equal.');
    end
else
    disp('The lengths of the files are not equal.');
end
