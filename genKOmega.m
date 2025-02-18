function K = genKOmega(mask, greyImg, sigma1, sigma2, p, KernelFcn, interval)
    q = 0.5;

    sz = size(mask);
    rOmega = sz(1);
    cOmega = sz(2);

    Dset = find(mask);
    [Dsetr, Dsetc] = ind2sub(sz, Dset);
    DLoc = [Dsetr, Dsetc];
    
    nTotal = length(Dset);
    K = zeros(rOmega, nTotal, cOmega);

    tempGreyImg = greyImg(:, :, 1); 
    DgreyImg = tempGreyImg(Dset);


    % if cOmega >= q * nTotal
        parfor i = 1:cOmega
            xLoc = [(1:rOmega)', i*ones(rOmega, 1)];
            K(:, :, i) = reKernal(xLoc, DLoc, tempGreyImg(:, i), DgreyImg, sigma1, sigma2, p, KernelFcn)';
        end  
    % else
    %     alt = {};
    % 
    % 
    %     parfor i = 1 : cOmega
    %         xLoc = [(1:rOmega)', i*ones(rOmega, 1)];
    %         K(:, :, i) = 
    % 
    % 
    % 
    %         yId = mod(i, nTotal);
    %         if yId == 0
    %             yId = nTotal;
    %         end
    %         DLoc = [Dsetr, Dsetc];
    %         yLoc = DLoc(yId, :)
    %         cNum = floor(i / nTotal) + 1;
    %         xLoc = [(1:rOmega)', cNum * ones(rOmega, 1)];
    %         tempK(:, i) = reKernal(xLoc, yLoc, tempGreyImg(:, cNum), DgreyImg(yLoc(1), yLoc(2)), sigma1, sigma2, p, KernelFcn);
    %     end
    %     K = reshape(tempK, size(K));
    % end


    

end