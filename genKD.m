function KD = genKD(mask, greyImg, sigma1, sigma2, p, KernelFcn)
    Dset = find(mask);
    [Dsetr, Dsetc] = ind2sub(size(mask), Dset);

    tempGreyImg = greyImg(:, :, 1); 
    DgreyImg = tempGreyImg(Dset);

    % [r, c] = find(tril(true(sz)));

    KD = reKernal([Dsetr, Dsetc], [Dsetr, Dsetc], DgreyImg, DgreyImg, sigma1, sigma2, p, KernelFcn);

end