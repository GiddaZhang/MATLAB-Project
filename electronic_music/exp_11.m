f_s = 8000;     % 8k采样
dt = 1/f_s;
T = 1/2;        % 每拍0.5s
t = 0:dt:T-dt;

episode = getEpisode('DFH');

f_standard = [164.81 174.61 196 207.65 220 246.94 261.63 293.66 ...
   329.63 349.23 392];

DFH = zeros(1, sum(episode(2,:))*f_s*T);
DFH_idx = 1;

realWave = audioread("fmt.wav");      % wavread函数已删除
[y, ~] = getFreqAndDistri(realWave, 'None');

for m = 1:length(episode)
%     freq = getFreq(episode(1, m)); 
    freq = getFreq(episode(1, m), 'Lower8'); 
    meter = episode(2, m);               % 拍数
    t_play = 0:dt:meter*T-dt;
    
    for k = 1:10
        if (abs(freq-f_standard(k))<1) || (abs(freq/2-f_standard(k))<1)
            harmonicAmph = y(k,:);
            break;
        end
    end
    combWave = zeros(1, length(t_play));
    for n = 1:10
        combWave = combWave + harmonicAmph(n)*sin(2*pi*(n*freq)*t_play);
    end

    combWave = addEnvelope(f_s, T*meter, combWave, 'guitar');

    idx_begin = DFH_idx;
    idx_end = idx_begin + meter*T*f_s - 1;  
    DFH(idx_begin:idx_end) = combWave;
    DFH_idx = idx_end + 1;    
end

% xlswrite("C:\Users\User\Desktop\song.xlsx", DFH);
% audiowrite("song_low.wav",DFH,8000);
% plot(DFH);
sound(DFH);