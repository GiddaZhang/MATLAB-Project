clear all;
N = 120;
load('test_img\hall.mat');
block = hall_gray(:,25:144);

D = getDCTOperator(N);

subplot(2,2,1);
imshow(block);
title('origin');

trans = D*(double(block)-128)*D';
trans_90 = rot90(trans);
trans_180 = rot90(trans, 2);
trans_transpose = trans';

inverse1 = D'*trans_90*D + 128;
inverse2 = D'*trans_180*D + 128;
inverse3 = D'*trans_transpose*D + 128;

subplot(2,2,2);
imshow(uint8(inverse1));
title('rot90');
subplot(2,2,3);
imshow(uint8(inverse2));
title('rot180');
subplot(2,2,4);
imshow(uint8(inverse3));
title('transpose');