function r = recaleRound(x, lim)
    % This function gives the rescaled x from original interval [oleft,oright] to [nleft, nright]  
    % x: quantity to be scaled
    % oleft, oright: original left and right end
    % nleft, nright: new left and right end

    oleft = lim(1);
    oright = lim(2);
    nleft = lim(3);
    nright = lim(4);
    r = uint8(round((oright - oleft) / (nright - nleft) * (x - nleft)));

end