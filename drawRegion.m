function mask = drawRegion(imgNow, img)
    roi = drawfreehand(imgNow, 'Color', 'r');
    pos = roi.Position;

    imgsz = size(img);

    xq = (1:imgsz(1))';
    q = zeros(imgsz(1)*imgsz(2), 2);
    for i = 1:imgsz(2)
        temp = [repmat(i, [imgsz(1), 1]), xq];
        q(1 + (i-1)*imgsz(1) : imgsz(1) + (i-1)*imgsz(1), :) = temp;
    end
    in = inpolygon(q(:, 1), q(:, 2), pos(:, 1), pos(:, 2));
    mask = zeros(imgsz(1), imgsz(2));
    nonzero = find(in);
    for i = nonzero'
        mask(q(i, 2), q(i, 1)) = 1;
    end

end