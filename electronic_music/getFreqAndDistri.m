function [y,f_sequence,tune] = getFreqAndDistri(music, ifPlot)

f_s = 8000;
f_num = 11;
f_base = zeros(f_num,1);
f_sequence = zeros(1,35);
tune = zeros(1,35);
numSameFreq = zeros(f_num,1);
y = zeros(f_num, 10);

f_standard = [164.81 174.61 196 207.65 220 246.94 261.63 293.66 ...
   329.63 349.23 392];
tune_standard = ['E' 'F' 'G' 'a' 'A' 'B' 'C' 'D' ...
    'E' 'F' 'G'];

for m = 1:35

    slice = getSlice(music, m);
    wave_extend = repmat(slice, 1000, 1);
    fourier = fft(wave_extend);
 
    [~, index] = max(abs(fourier));

    f_step = f_s/length(fourier);
    f = index*f_step;
    if f > 400.0
        f = f/2;        % 可能误把谐波当作基波
    end
    
    for k = 1:f_num

        if abs(f-f_standard(k))<6 

            f_sequence(m) = f_standard(k);
            tune(m) = tune_standard(k);

            if f_base(k) == 0
                f_base(k) = f_standard(k);      % 记录频率
                
                for n = 1:10
                    begin_idx = round(0.95*n*f/f_step);
                    end_idx = round(1.05*n*f/f_step);
                    [y(k,n), ~] = max(abs(fourier(begin_idx:end_idx)));
                    y(k,n) = y(k,n)*f_step;
                end
                % 归一化
                y(k,:) = y(k,:)/y(k,1);
                break;
            else
                numSameFreq(k) = numSameFreq(k)+1; 
                % 取平均值
                tmp = zeros(1, 10);
                for n = 1:10
                    begin_idx = round(0.95*n*f/f_step);
                    end_idx = round(1.05*n*f/f_step);
                    [tmp(n), ~] = max(abs(fourier(begin_idx:end_idx)));
                    tmp(n) = tmp(n)*f_step;
                end
                tmp(:) = tmp(:)/tmp(1);
                y(k,:) = (numSameFreq(k)-1)/numSameFreq(k)*y(k,:) + 1/numSameFreq(k)*tmp; 
            end
        end

    end
end

if strcmp(ifPlot, 'y')
    figure(2);
    for m = 1:11
        subplot(4,3,m);
        bar(y(m,:));
        title('f = ', f_standard(m));
    end
end
end