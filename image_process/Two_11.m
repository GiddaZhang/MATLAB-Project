clear all;
load("Chapter_2\jpegcodes.mat");

% DCStream解码
DC = deCodeDCStream(DCStream);

% ACStream解码
AC = decodeACStream(ACStream, DC);

% 反zigzag-反量化-拼接
img = DCTZigZagMat2Img([DC;AC], y, x, "NormStep");

load("test_img\hall.mat");
subplot(1,2,1);
imshow(hall_gray);
title('Origin');
subplot(1,2,2);
imshow(img);
title('Decode');

% 计算压缩比
compress_ratio = size(hall_gray, 1)*size(hall_gray, 2)*8 / (length(ACStream) + length(DCStream))

% 计算PSNR
PixelNum = x * y;
MSE = sum((double(img) - double(hall_gray)).^2, 'all') / PixelNum;
PSNR = 10 * log10(255*255/MSE)