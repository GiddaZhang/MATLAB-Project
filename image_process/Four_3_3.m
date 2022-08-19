clear all;
img = imread("Chapter_4\photo.jpg");
% img = imadjust(img, [.2 .1 0; 1 1 1],[]);       % 变黑
img = imadjust(img, [], [0.1 0.1 0.1; 1 1 1]);  % 变白
imshow(img);
L = 4;

load("Chapter_4\v_L4.mat");
img_show = faceIdentify(img, L, u_bar);
imshow(img_show);
