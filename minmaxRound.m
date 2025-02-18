function r = minmaxRound(x, lim)
% This function gives the limit round shceme 
    if lim(1) > lim(2)
        error("Round limit illegal.")
    end
    r = uint8(x);
    r(r < uint8(lim(1))) = uint8(lim(1));
    r(r > uint8(lim(2))) = uint8(lim(2));

end