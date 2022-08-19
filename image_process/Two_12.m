clear all;
% 获取DCT系数矩阵
load("test_img\hall.mat")
[MAT, y, x] = getDCTZigZagMat(hall_gray, 'HalfStep');

% 获取DC系数码流
DCStream = getDCStream(MAT);

% 获取AC系数码流
ACStream = getACStream(MAT);

% DCStream解码
DC = deCodeDCStream(DCStream);

% ACStream解码
AC = decodeACStream(ACStream, DC);

% 反zigzag-反量化-拼接
img = DCTZigZagMat2Img([DC;AC], y, x, "HalfStep");

load("test_img\hall.mat");
subplot(2,1,1);
imshow(hall_gray);
subplot(2,1,2);
imshow(img);

% 计算压缩比
compress_ratio = size(hall_gray, 1)*size(hall_gray, 2)*8 / (length(ACStream) + length(DCStream))

% 计算PSNR
PixelNum = x * y;
MSE = sum((double(img) - double(hall_gray)).^2, 'all') / PixelNum;
PSNR = 10 * log10(255*255/MSE)