function greyImg = genGreyImg(filename)
    img = imread(filename);
    greyImg = repmat(round(0.3 * img(:, :, 1) + 0.59 * img(:, :, 2) + 0.11 * img(:, :, 3)), [1, 1, 3]);
    
end