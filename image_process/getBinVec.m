function y = getBinVec(x)
% 输入整数x，返回二进制向量y
bin = dec2bin(abs(x));
y = zeros(1, length(bin));
for m = 1:length(bin)
    y(m) = bin(m) - '0';
end
if x < 0
    y = ~y;
end