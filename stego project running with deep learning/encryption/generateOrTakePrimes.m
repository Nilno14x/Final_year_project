
function [p, q] = generateOrTakePrimes()
    %choice = input('Do you want to generate prime numbers? (y/n): ', 's');
    %if lower(choice) == 'y'
        % Generate two prime numbers
        p = generatePrime();
        q = generatePrime();
    %else
        % Take user-provided prime numbers
     %   p = input('Enter the first prime number (p): ');
      %  q = input('Enter the second prime number (q): ');
       % if ~isprime(p) || ~isprime(q)
       %     error('Both numbers must be prime.');
       % end
    %end
end
