function k = gaussianKernel(r)
    % This function gives a Gaussian Kernel.
    % Note that r >= 0.
    k = exp(-r.^2);
end