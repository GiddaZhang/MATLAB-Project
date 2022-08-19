function y = RGB2N(RGB, L)
% 根据输入L以及RGB值将RGB转换为自然数N
R = RGB(1);
G = RGB(2);
B = RGB(3);
R = floor(double(R) / 2^(8 - L));
G = floor(double(G) / 2^(8 - L));
B = floor(double(B) / 2^(8 - L));

y = R*2^(2*L) + G*2^L + B;

end