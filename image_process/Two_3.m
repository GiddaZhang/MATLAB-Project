clear all;
N = 120;
load('test_img\hall.mat');
block = hall_gray(:,25:144);

D = getDCTOperator(N);

subplot(1,3,1);
imshow(block);
title('origin');

trans = D*(double(block)-128)*D';
trans_leftzero = trans;
trans_leftzero(:, 1:N/2) = 0;
trans_rightzero = trans;
trans_rightzero(:, N/2+1:N) = 0;

inverse1 = D'*trans_leftzero*D + 128;
inverse2 = D'*trans_rightzero*D + 128;

subplot(1,3,2);
imshow(uint8(inverse1));
title('kill left half of columns');
subplot(1,3,3);
imshow(uint8(inverse2));
title('kill right half of columns');