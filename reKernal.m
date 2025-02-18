function K = reKernal(x, y, gamma_x, gamma_y, sigma1, sigma2, p, KernelFcn)
    % x and y are coords of pixels, vector like
    % gamma_x and gamma_y are greyscaled value of x and y
    % sigma1, sigma2 and p are parameters
    % KernelFcn is the name of kernel function used   
    gamma_x = double(gamma_x);
    gamma_y = double(gamma_y);

    % Squared Euclidean distance matrix (N×M)
    distMat = pdist2(y, x);

    % Compute grayscale differences (N×M)
    gammaDiff = abs(gamma_x' - gamma_y);
    
    switch KernelFcn
        case "Gaussian"
            K = gaussianKernel(distMat ./ sigma1) ...
                .* gaussianKernel(gammaDiff .^ p ./ sigma2);

        case "CSRBF"
            K = CSRBF(distMat ./ sigma1) ...
                .* CSRBF(gammaDiff .^ p ./ sigma2);

        otherwise
            error("Kernel Function Name Error.")
    end

end