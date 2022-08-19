function y = str2bin(str)
% 将str转换成二进制流
str_ascii = abs(str);
bin = de2bi(str_ascii, 8);
y = reshape(bin', 1, size(bin,1)*size(bin,2));
end