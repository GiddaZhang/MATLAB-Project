clear

[y, fourier, f] = getHarmonic();

subplot(2,1,1);
plot(f, fourier);

subplot(2,1,2);
bar(y);