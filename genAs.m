function coef = genAs(KD, delta, fs)
    [n, ~] = size(KD);
    coef = (KD + n * delta * eye(size(KD))) \ fs;
        
end