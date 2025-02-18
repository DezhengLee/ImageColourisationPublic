function f = Dmap(r, c, s, maskedImage, mask)
    % This function gives the rgb of a given pixel (r, c) in coloured set D
    % Generate components of f^s in the given lecture.
    % r, c: row and column
    % s: number of rgb, r: 1; g: 2; b:3
    % orImage: original image
    % mask: image mask, coloured with 1s and grey in 0s
    if s < 1 || s > 3
        error("Invaild layer. s should be an integer within [1, 3]")
    end

    if mask(r, c) == 1
        f = maskedImage(r, c, s);
    elseif mask(r, c) == 0
        error("Pixel seclected is not in coloured set.")
    else
        error("Mask input is illegal.")
    end
end