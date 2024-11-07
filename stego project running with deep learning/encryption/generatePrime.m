function prime = generatePrime()
    while true
        % Generate a random integer between 50 and 100
        candidate = randi([50, 100], 1, 1);
        
        % Check if the candidate is prime
        if isprime(candidate)
            prime = candidate;
            break;
        end
    end
end