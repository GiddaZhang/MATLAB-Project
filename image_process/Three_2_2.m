clear all;
load('test_img\hall.mat');

hiddenInfoStream = str2bin('MATLAB IS FUN!');
hiddenInfoLen = length(hiddenInfoStream);

% jpeg压缩解压缩
[MAT, y, x] = getDCTZigZagMat(hall_gray, 'NormStep');

% 插入隐藏信息，替换直流分量的最低位
for m = 1:hiddenInfoLen
    DCTCoeff = MAT(1, m);
    if DCTCoeff >= 0
        originBin = de2bi(DCTCoeff, 8);
        originBin(1) = hiddenInfoStream(m);
        MAT(1, m) = bi2de(originBin);
    else
        originBin = de2bi(-DCTCoeff, 8);
        originBin(1) = hiddenInfoStream(m);
        MAT(1, m) = -bi2de(originBin);
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
    DCTCoeff = MAT_hidden(1, m);
    if DCTCoeff >= 0
        hiddenBin = de2bi(DCTCoeff, 8);
    else
        hiddenBin = de2bi(-DCTCoeff, 8);   
    end
    infoBit = hiddenBin(1);
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
