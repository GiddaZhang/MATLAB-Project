clear all;
% 获取DCT系数矩阵
load("Chapter_2\snow.mat");
[MAT, y, x] = getDCTZigZagMat(snow, 'NormStep');

% 获取DC系数码流
DCStream = getDCStream(MAT);

% 获取AC系数码流
ACStream = getACStream(MAT);

% DCStream解码
DC = deCodeDCStream(DCStream);

% ACStream解码
AC = decodeACStream(ACStream, DC);

% 反zigzag-反量化-拼接
img = DCTZigZagMat2Img([DC;AC], y, x, "NormStep");

load("Chapter_2\snow.mat");
subplot(1,2,1);
imshow(snow);
title('Origin');
subplot(1,2,2);
imshow(img);
title('Decode');

% 计算压缩比
compress_ratio = size(snow, 1)*size(snow, 2)*8 / (length(ACStream) + length(DCStream))

% 计算PSNR
PixelNum = x * y;
MSE = sum((double(img) - double(snow)).^2, 'all') / PixelNum;
PSNR = 10 * log10(255*255/MSE)