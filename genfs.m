function fs = genfs(maskedImg, mask, s)
    idx = find(mask);
    n = size(idx, 1);
    
    fs = zeros([n, 1]);
    sz = size(mask);
    for i = 1:n
        [ir, ic] = ind2sub(sz, idx(i));
        fs(i) = Dmap(ir, ic, s, maskedImg, mask);
    end

end