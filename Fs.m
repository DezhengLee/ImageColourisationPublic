function res = Fs(xr, xc, as, mask, greyImg, sigma1, sigma2, p, KernelFcn)
    % This function gives recovered colour info of pixel located at [xr,
    % xc], in colour chanel s.

    Dset = find(mask);
    sz = size(mask);
    if length(as) ~= length(Dset)
        error("INPUT ERROR!")
    end

    [Dsetr, Dsetc] = ind2sub(sz, Dset);
    % Following command will lead to memory out
    Ks = reKernal([xr, xc], [Dsetr, Dsetc], greyImg(sub2ind(sz, xr, xc, 1)), greyImg(sub2ind(sz, Dsetr, Dsetc, 1)), sigma1, sigma2, p, KernelFcn);
    % TO DO
    % Ks = 
    res = Ks' * as;



    % 
    % for j = 1:length(Dset)
    %     [xjr, xjc] = ind2sub(sz, Dset(j));
    %     temp = reKernal([xr, xc], [xjr, xjc], greyImg(xr, xc, 1), greyImg(xjr, xjc, 1), sigma1, sigma2, p , KernelFcn);
    %     res = res + temp * as(j);
    % end

end