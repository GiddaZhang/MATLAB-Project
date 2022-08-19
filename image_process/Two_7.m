clear all;
N = 8;
% zigzag = getZigZag(N)
% save('Chapter_2/zigzag.mat', 'zigzag');
load('Chapter_2/zigzag.mat');

zigzag
A = randi(8,8)
A_trans = A';
scan = zeros(1,N^2);
idx = 1;
for i = 1:N
    for j = 1:N
        scan(zigzag(i,j)) = A_trans(idx);
        idx = idx + 1;
    end
end
scan