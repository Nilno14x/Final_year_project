%clc
%clear all
%close all

function [publicKey, privateKey, encryptedMessage] = encryptMessage()
    clc;
    disp('RSA algorithm');
    
    % Generate or take prime numbers
    [p, q] = generateOrTakePrimes();
    
    n = p * q;
    fprintf('\nn=%d', n);
    
    phi = (p-1) * (q-1);
    fprintf('\nphi(%d) is %d', n, phi);
    
    val = 0;
    cd = 0;

    % Generate public and private keys
    while(cd ~= 1 || val == 0)
        n1 = randi(n,1, 1);
        e = randi([2, n1],1, 1);
        val = isprime(e);
        cd = gcd(e, phi);
    end

    val1 = 0;
    d = 0;
    while(val1 ~= 1)
        d = d + 1;
        val1 = mod(d * e, phi);
    end
    
    fprintf('\nd=%d\n', d);
    publicKey = struct('e', e, 'n', n);
    privateKey = struct('d', d, 'n', n);
    
    %m = input('\nEnter the message: ', 's');
    %m1 = double(m);
    
    key_file_path = 'D:\stego project running\text\secret_key.txt';
    fileID = fopen(key_file_path,'r');
    key = fscanf(fileID,'%c',16);
    fclose(fileID);
    disp(key);
    
    m1 = double(key);
    disp('ASCII equivalent of message ');
    disp(m1);
    
    over = length(m1);
    o = 1;
    
    % Encrypt the message
    encryptedMessage = zeros(1, over);
    while(o <= over)
        m = m1(o);
        diff = 0;
        if(m > n)
            diff = m - n + 1;
        end
        m = m - diff;
        
        qm = dec2bin(e);
        len = length(qm);
        c = 1;
        xz = 1;
        while(xz <= len)  
            if(qm(xz) == '1')
                c = mod(mod((c^2), n) * m, n);
            elseif(qm(xz) == '0')
                c = mod(c^2, n);
            end
            xz = xz + 1;
        end
        encryptedMessage(o) = c + diff;
        o = o + 1;
    end
    
    filename = 'D:\stego project running\text\rsa_enc_dec.txt';
    dlmwrite(filename, encryptedMessage, 'delimiter', '\t');
    fprintf('\nEncrypted message saved to %s\n', filename);
    
    % Display public and private keys
    %disp('Public key:');
    %disp(publicKey);
    fprintf('\nPublic key: %d\n',n);
    
    %disp('Private key:');
    %disp(privateKey);
    fprintf('\nPrivate key: %d\n',d);
    
    fprintf('\nThe Value of n: %d\n',e);
    
    publicFilePath='D:\stego project running\text\public_key.txt';
    fid = fopen(publicFilePath, 'w');
    fprintf(fid, '%d', n);
    fclose(fid);
    
    privateFilePath='D:\stego project running\text\private_key.txt';
    fid = fopen(privateFilePath, 'w');
    fprintf(fid, '%d', d);
    fclose(fid);
end
