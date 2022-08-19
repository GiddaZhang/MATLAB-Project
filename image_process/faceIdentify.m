function img_show = faceIdentify(img, L, v)
% 返回识别人脸的图像

faceSize = [60, 60];
imgSize = [size(img, 1), size(img, 2)];

rectangleLen = 4;
epsilon = 0.32;
img_show = img;
yStep = 10;
xStep = 10;
rectangleNum = 0;

% 记录矩形顶点
yxs = zeros(4, 300);
% 依次为y1, x1, y2, x2，内边框

% 画红框
for row = 1:yStep:(imgSize(1)-faceSize(1))

    for col = 1:xStep:(imgSize(2)-faceSize(2))

        leftBond = col;
        rightBond = col + faceSize(2);
        upperBond = row;
        lowerBond = row + faceSize(1);

        imgPiece = img(upperBond:lowerBond, leftBond:rightBond, :);

        u = getImgVec(imgPiece, L);

        d = 1 - sum(sqrt(u.*v));

        if d < epsilon
            img_show = drawRedRectangle(img_show, upperBond, leftBond, lowerBond, rightBond, rectangleLen);
            
            rectangleNum = rectangleNum + 1;
            yxs(:, rectangleNum) = [upperBond+rectangleLen;leftBond+rectangleLen;lowerBond-rectangleLen;rightBond-rectangleLen];
        end
    end
end

% 消重复画的框
isInRectangle = false;
for y = 1:imgSize(1)
    for x = 1:imgSize(2)
        for yxIdx = 1:rectangleNum
            if y > yxs(1, yxIdx) && y < yxs(3, yxIdx) && x > yxs(2, yxIdx) && x < yxs(4, yxIdx)
                isInRectangle = true;
                break;
            end
        end
        if isInRectangle
            img_show(y, x, :) = img(y, x, :);
        end
        isInRectangle = false;
    end
end

end