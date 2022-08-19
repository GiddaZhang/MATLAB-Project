clear all;
f_s = 8000;     % 8k采样
dt = 1/f_s;
T = 1/4;        % 每拍0.5s
t = 0:dt:T-dt;

episode = getEpisode('DFHSlice');

[harmonicAmph,~,~] = getHarmonic();

DFH = zeros(1, sum(episode(2,:))*f_s*T);
DFH_idx = 1;

for m = 1:length(episode)
    freq = getFreq(episode(1, m)); 
    meter = episode(2, m);               % 拍数
    t_play = 0:dt:meter*T-dt;
    
    combWave = zeros(1, length(t_play));
    for n = 1:10
        combWave = combWave + harmonicAmph(n)*sin(2*pi*(n*freq)*t_play);
    end

    combWave = addEnvelope(f_s, T*meter, combWave, 'exp');

    idx_begin = DFH_idx;
    idx_end = idx_begin + meter*T*f_s - 1;  
    DFH(idx_begin:idx_end) = DFH(idx_begin:idx_end) + combWave;

    DFH_idx = idx_end + 1; 
end

sound(DFH);