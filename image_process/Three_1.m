clear all
load('test_img\hall.mat');

hiddenInfoStream = str2bin('MATLAB IS FUN!');
hiddenInfoLen = length(hiddenInfoStream);
% 插入隐藏信息
hall_gray_hidden = hall_gray;
for m = 1:hiddenInfoLen
    originBin = de2bi(hall_gray_hidden(1, m), 8);
    originBin(1) = hiddenInfoStream(m);
    hall_gray_hidden(1, m) = bi2de(originBin);
end

% 获取隐藏信息1
deCodeInfoStream = zeros(hiddenInfoLen/8, 8);
for m = 1:hiddenInfoLen
    hiddenBin = de2bi(hall_gray_hidden(1, m), 8);
    infoBit = hiddenBin(1);
    row = ceil(m/8);
    col = m - (row - 1)*8;
    deCodeInfoStream(row, col) = infoBit;
end
str_ascii = bi2de(deCodeInfoStream);
char(reshape(str_ascii, 1, 14))

% jpeg压缩解压缩
[MAT, y, x] = getDCTZigZagMat(hall_gray_hidden, 'NormStep');
DCStream = getDCStream(MAT);
ACStream = getACStream(MAT);
DC = deCodeDCStream(DCStream);
AC = decodeACStream(ACStream, DC);
img = DCTZigZagMat2Img([DC;AC], y, x, "NormStep");

% 获取隐藏信息2
deCodeInfoStream = zeros(hiddenInfoLen/8, 8);
for m = 1:hiddenInfoLen
    hiddenBin = de2bi(img(1, m), 8);
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
imshow(hall_gray_hidden);
title('HiddenInfo');