function img = DCTZigZagMat2Img(MAT, y, x, step)
% 将分块、DCT和量化之后的经过Zigzag扫描的系数矩阵还原回图片

img = zeros(y, x);
load('Chapter_2\zigzag.mat');
load('Chapter_2\JpegCoeff.mat');
DC = MAT(1, :);
AC = MAT(2:end, :);

for blockIdx = 1:length(DC)

    block = zeros(8, 8);
    % 反zigzag
    for m = 1:8
        for n = 1:8
            if m == 1 && n == 1
                block(m, n) = DC(blockIdx);
            else
                acIdx = zigzag(m, n) - 1;
                block(m, n) = AC(acIdx, blockIdx);
            end
        end
    end

    % 反量化
    if strcmp(step, "HalfStep")
        block = block .* QTAB ./ 2;
    else
        block = block .* QTAB;
    end

    % 反变换
    block = idct2(block);

    % 拼接
    row = ceil(blockIdx / (x/8));
    col = blockIdx - (row-1)*(x/8);
    img((row-1)*8+1:row*8,(col-1)*8+1:col*8) = block;
end

img = uint8(img + 128);

end