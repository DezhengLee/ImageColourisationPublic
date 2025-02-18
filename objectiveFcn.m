function f = objectiveFcn(filename, percentage, para, delta, KernelFcn, roundScheme, samplingScheme)
    sigma1 = para(1);
    sigma2 = para(2);
    p = para(3);
    [rev, ~, mask] = ImgRecovery(filename, percentage, sigma1, sigma2, p, delta, KernelFcn, roundScheme, samplingScheme);
    Dset = find(mask);
    orImg = imread(filename);
    m = size(Dset, 1);
    f = 0;
    for i = 1:3
        revl = rev(:, :, i);
        orImgl = orImg(:, :, i); 
        f = f + sum(sum((revl(Dset) - orImgl(Dset)).^2));
    end
    f = f/(3*m);

end