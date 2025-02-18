function img =  recoverImg(ar, ag, ab, mask, greyImg, sigma1, sigma2, p, KernelFcn, roundScheme)    
    sz = size(mask);
    img = uint8(zeros([sz, 3]));
    rlayer = zeros(sz);
    glayer = zeros(sz);
    blayer = zeros(sz);

    s1 = sz(1);
    s2 = sz(2);

    [xr, xc] = ind2sub(sz, 1:s1*s2);

    rRes = round(Fs(xr', xc', ar, mask, greyImg, sigma1, sigma2, p, KernelFcn));
    gRes = round(Fs(xr', xc', ag, mask, greyImg, sigma1, sigma2, p, KernelFcn));
    bRes = round(Fs(xr', xc', ab, mask, greyImg, sigma1, sigma2, p, KernelFcn));

    rlayer(:) = rRes;
    glayer(:) = gRes;
    blayer(:) = bRes;

    switch roundScheme
        case "Rescale"     
            rlayer = recaleRound(rlayer, [0, 255, min(rlayer, [], "all"), max(rlayer, [], "all")]);
            glayer = recaleRound(glayer, [0, 255, min(glayer, [], "all"), max(glayer, [], "all")]);
            blayer = recaleRound(blayer, [0, 255, min(blayer, [], "all"), max(blayer, [], "all")]);
        case "MinMax"
            rlayer = minmaxRound(rlayer, [0, 255, min(rlayer, [], "all"), max(rlayer, [], "all")]);
            glayer = minmaxRound(glayer, [0, 255, min(glayer, [], "all"), max(glayer, [], "all")]);
            blayer = minmaxRound(blayer, [0, 255, min(blayer, [], "all"), max(blayer, [], "all")]);
        otherwise
            error("ERROR IN ROUND SCHEME!")
    end

    img(:, :, 1) = uint8(rlayer);
    img(:, :, 2) = uint8(glayer);
    img(:, :, 3) = uint8(blayer);

end

