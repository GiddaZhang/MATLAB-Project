clear all;
img = imread("Chapter_4\photo.jpg");
img = imrotate(img, -90);
L = 4;

load("Chapter_4\v_L4.mat");
img_show = faceIdentify(img, L, u_bar);
imshow(img_show);