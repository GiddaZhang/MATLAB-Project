clear all;
load("test_img\hall.mat");
load("Chapter_2\jpegcodes.mat");

output = length(ACStream) + length(DCStream);
input = size(hall_gray, 1) * size(hall_gray, 2) * 8;

compress_ratio = input / output