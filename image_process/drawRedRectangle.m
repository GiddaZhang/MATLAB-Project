function img_new = drawRedRectangle(img, y1, x1, y2, x2, rectangleLen)

    
    img(y1:y1+rectangleLen, x1:x2, 1) = uint8(255); 
    img(y1:y1+rectangleLen, x1:x2, 2) = uint8(0);  
    img(y1:y1+rectangleLen, x1:x2, 3) = uint8(0); 

    img(y2-rectangleLen:y2, x1:x2, 1) = uint8(255); 
    img(y2-rectangleLen:y2, x1:x2, 2) = uint8(0);  
    img(y2-rectangleLen:y2, x1:x2, 3) = uint8(0); 

    img(y1:y2, x1:x1+rectangleLen, 1) = uint8(255); 
    img(y1:y2, x1:x1+rectangleLen, 2) = uint8(0);  
    img(y1:y2, x1:x1+rectangleLen, 3) = uint8(0); 

    img(y1:y2, x2-rectangleLen:x2, 1) = uint8(255); 
    img(y1:y2, x2-rectangleLen:x2, 2) = uint8(0);  
    img(y1:y2, x2-rectangleLen:x2, 3) = uint8(0); 

    img_new = img;
end