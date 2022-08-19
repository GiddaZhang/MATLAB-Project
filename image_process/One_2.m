clear all;

hall = load("test_img\hall.mat");
img_test = hall.hall_color;
[width, length, rgb] = size(img_test);

% 画圆开始
img_circle = img_test;
circle_center_x = length / 2;
circle_center_y = width / 2;
radius = min(circle_center_y, circle_center_x);

for m = 1:width
    for n = 1:length
        distance_square = (m - circle_center_y)^2 + (n - circle_center_x)^2;
        if distance_square < radius^2
            img_circle(m,n,:) = [uint8(255);uint8(0);uint8(0)];   % 红色
        end
    end
end
% 画圆结束，存储到addCirc.png
imwrite(img_circle, "test_img\addCirc.png");

% 棋盘格开始
img_chessboard = img_test;
borad_size = 8;
for m = 1:width
    for n = 1:length
        if rem(m, borad_size) < borad_size/2
            if rem(n, borad_size) < borad_size/2
                img_chessboard(m,n,:) = [uint8(0);uint8(0);uint8(0)];   % 黑色
            end
        else
            if rem(n, borad_size) >= borad_size/2
                img_chessboard(m,n,:) = [uint8(0);uint8(0);uint8(0)];   % 黑色
            end
        end
    end
end
% 棋盘格结束，存储到addChessboard.png
imwrite(img_chessboard, "test_img\addChessboard.png");