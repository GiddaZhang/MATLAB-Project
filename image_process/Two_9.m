clear all;
load("Chapter_2\JpegCoeff.mat")
load("test_img\hall.mat")

% 获取DCT系数矩阵
[MAT, y, x] = getDCTZigZagMat(hall_gray, 'NormStep');

% 获取DC系数码流
DCStream = getDCStream(MAT);

% 获取AC系数码流
ACStream = getACStream(MAT);

save("Chapter_2\jpegcodes.mat", 'DCStream', 'ACStream', 'y', 'x');
