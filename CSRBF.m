function k = CSRBF(r)
    % This function gives Compactly Supported RBF.
    % Note that r >= 0.
    k = (max(1 - r, 0)).^4 .* (4*r+1);
end