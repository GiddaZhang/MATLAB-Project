clear all;
img = imread("Chapter_4\photo.jpg");
img = imresize(img, [size(img, 1) size(img, 2)*2]);
L = 4;

load("Chapter_4\v_L4.mat");
img_show = faceIdentify(img, L, u_bar);
imshow(img_show);