function combined = combineMaskedImg(img, greyImg, mask)

    % Assuming in mask, 1s have original colour and are greyscaled otherwise
    combined = greyImg;
    idx = find(mask);
    for i = 1:3
        slice = combined(:, :, i);
        imgSlice = img(:, :, i);
        slice(idx) = imgSlice(idx);
        combined(:, :, i) = slice;
    end

end