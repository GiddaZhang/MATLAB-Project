function [MAT, y, x] = getDCTZigZagMat(img, step)

% 输入测试图像，返回进行分块、DCT和量化之后的经过Zigzag扫描的系数矩阵，图像宽、长

[y,x] = size(img);
block_y = y / 8;
block_x = x / 8;
block_num = block_x * block_y; 
MAT = zeros(64, block_num);

for idx = 1:block_num

    % 分块
    row = ceil(idx / block_x);
    col = idx - (row - 1) * block_x;
    block = img(8*(row-1)+1:8*row,8*(col-1)+1:8*col);

    % DCT
    dct = DCT8(block);

    % 量化
    load('Chapter_2\JpegCoeff.mat');
    if strcmp(step, 'HalfStep')
        dct = round(dct./QTAB*2);
    else
        dct = round(dct./QTAB);
    end

    % zigzag
    load('Chapter_2\zigzag.mat');
    scan = zeros(64,1);
    A_trans = dct';
    m = 1;
    for i = 1:8
        for j = 1:8
            scan(zigzag(i,j)) = A_trans(m);
            m = m + 1;
        end
    end
    MAT(:, idx) = scan;

end

end