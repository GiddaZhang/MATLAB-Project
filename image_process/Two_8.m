clear all
load("test_img\hall.mat")

MAT = getDCTZigZagMat(hall_gray, 'NormStep');
