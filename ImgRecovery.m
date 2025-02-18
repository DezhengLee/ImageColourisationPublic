function [img, comb, mask] = ImgRecovery(filename, percentage, sigma1, sigma2, p, delta, KernelFcn, roundScheme, samplingScheme)

    orImg = imread(filename);
    size(orImg)
    greyImg = genGreyImg(filename);
    switch samplingScheme
        case "Uniform"
            mask = genUnif(orImg, percentage);
        case "Random"
            mask = genRand(orImg, percentage);
        otherwise
            pass
    end
    comb = combineMaskedImg(orImg, greyImg, mask);
    sz = size(mask);
    img = uint8(zeros([sz, 3]));

    KD = genKD(mask, greyImg, sigma1, sigma2, p, KernelFcn);
    K = genKOmega(mask, greyImg, sigma1, sigma2, p, KernelFcn);

    Ksz = size(K);

    fr = genfs(comb, mask, 1);
    fg = genfs(comb, mask, 2);
    fb = genfs(comb, mask, 3);

    ar = genAs(KD, delta, fr);
    ag = genAs(KD, delta, fg);
    ab = genAs(KD, delta, fb);

    rlayer = zeros(sz);
    glayer = zeros(sz);
    blayer = zeros(sz);

    parfor i = 1:Ksz(3)
        rlayer(:, i) =  K(:, :, i) * ar;
        glayer(:, i) =  K(:, :, i) * ag;
        blayer(:, i) =  K(:, :, i) * ab;
    end
    
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