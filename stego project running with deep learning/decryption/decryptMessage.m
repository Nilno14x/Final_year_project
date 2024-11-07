
function decryptedMessage = decryptMessage(publicKey, privateKey,encryptedMessage)
    clc;
    disp('RSA algorithm - Decryption');
    
    n = publicKey;
    %phi = (publicKey - 1) * (publicKey - 1);
    d = privateKey;
    
    over = length(encryptedMessage);
    o = 1;
    
    % Decrypt the message
    decryptedMessage = char(zeros(1, over));
    while(o <= over)
        c = encryptedMessage(o);
        
        qm1 = dec2bin(d);
        len1 = length(qm1);
        nm = 1;
        xy = 1;
        while(xy <= len1)    
            if(qm1(xy) == '1')
                nm = mod(mod((nm^2), n) * c, n);
            elseif(qm1(xy) == '0')
                nm = mod(nm^2, n);
            end
            xy = xy + 1;
        end
        nm = nm + 0; % No need to subtract diff during decryption
        
        decryptedMessage(o) = char(nm);
        o = o + 1;
    end
    
    % Display decrypted message
    %fprintf('\nThe decrypted message is: %s\n', decryptedMessage);
end
