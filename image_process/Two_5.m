clear all;

% H(z) = 1 - z^(-1)
b = [-1, 1];
a = 1;

freqz(b, a);

