clear all;
N = 8;
load('test_img\hall.mat');
block = hall_gray(25:32, 25:32) - 128;

D = getDCTOperator(N);
myDCT = D*double(block)*D';
matlabDCT = dct2(block);

matlabDCT
myDCT