function mask = genUnif(img, percent)
    percent = 0.01 * percent;
    imgsz = size(img);
    numPixel = imgsz(1) * imgsz(2);
    numSelectedPix = round(numPixel * percent);
    if numSelectedPix < 1
        errordlg('Sample number less than 1 pixel.')
    end

    interval = round(numPixel / numSelectedPix);
    i = 1;
    mask = zeros(imgsz(1), imgsz(2));
    while i <= imgsz(1)*imgsz(2)
        mask(i) = 1;
        i = i + interval;
    end
    
end