clear all;
load('test_img\hall.mat');

hiddenInfoStream = str2bin('MATLAB IS FUN!');
hiddenInfoLen = length(hiddenInfoStream);

% jpeg压缩解压缩
[MAT, y, x] = getDCTZigZagMat(hall_gray, 'NormStep');

% 插入隐藏信息，在每个块最后一个非零系数后添加1或-1
for m = 1:hiddenInfoLen
    Idx = find(MAT(:, m), 1, 'last');
    if Idx ~= 64
        Idx = Idx + 1;
    end
    if hiddenInfoStream(m) == 0
        MAT(Idx, m) = -1;
    else
        MAT(Idx, m) = 1;
    end
end

DCStream = getDCStream(MAT);
ACStream = getACStream(MAT);
DC = deCodeDCStream(DCStream);
AC = decodeACStream(ACStream, DC);
img = DCTZigZagMat2Img([DC;AC], y, x, "NormStep");

% 获取隐藏信息
deCodeInfoStream = zeros(hiddenInfoLen/8, 8);
% jpeg压缩
[MAT_hidden, y, x] = getDCTZigZagMat(img, 'NormStep');

for m = 1:hiddenInfoLen
    Idx = find(MAT(:, m), 1, 'last');
    DCTCoeff = MAT_hidden(Idx, m);
    if DCTCoeff == -1
        infoBit = 0;
    else
        infoBit = 1;   
    end
    row = ceil(m/8);
    col = m - (row - 1)*8;
    deCodeInfoStream(row, col) = infoBit;
end

str_ascii = bi2de(deCodeInfoStream);
char(reshape(str_ascii, 1, 14))

subplot(1,2,1);
imshow(hall_gray);
title('Origin');
subplot(1,2,2);
imshow(img);
title('HiddenInfo');
