clear all;

load('test_img\hall.mat');
block = hall_gray(25:32, 25:32);

block_1 = dct2(block - 128);

All128 = zeros(8, 8) + 128;
block_2 = dct2(block) - dct2(All128);

block_1
block_2