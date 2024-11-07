function hexValue = removePadding(hexValue)
    % Remove padding if the last character is '0'
    while hexValue(end) == '0'
        hexValue = hexValue(1:end-2);
    end
end