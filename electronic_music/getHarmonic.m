function [y, fourier, f] = getHarmonic()
load("Guitar.MAT");

% wave_extend = repmat(wave2proc, 1000, 1);
wave_extend = wave2proc;
fourier = abs(fft(wave_extend));

% 计算10次谐波, f_0=330Hz
f_0 = 330;
f_s = 8000;
f_step = f_s/length(fourier);
f = 0:f_step:f_s-f_step;

y = zeros(10,1);
for m = 1:10
    begin_idx = round((m-1)*f_0/f_step)+1;
    end_idx = round(m*f_0/f_step);
    y(m) = max(fourier(begin_idx:end_idx));
end
y = y/ y(1);    % 归一化
end