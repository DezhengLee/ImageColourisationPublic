function mask = genRand(img, percent)
    percent = 0.01 * percent;
    imgsz = size(img);
    numPixel = imgsz(1) * imgsz(2);
    numSelectedPix = round(numPixel * percent);
    if numSelectedPix < 1
        errordlg('Sample number less than 1 pixel.')
    end
    mask = zeros(imgsz(1), imgsz(2));
    mask(randi(imgsz(1)*imgsz(2), [1, numSelectedPix])) = 1;

end