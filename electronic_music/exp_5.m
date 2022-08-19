% 夜空中最亮的星——逃跑计划(前八小节)
clear all;

f_s = 8000;     % 8k采样
dt = 1/f_s;
T = 1/4;        % 每拍0.25s
t = 0:dt:T-dt;

episode = getEpisode('Star');
Star = zeros(1, sum(episode(2,:))*f_s*T);
idx = 1;

for m = 1:length(episode)
    freq = getFreq_5(episode(1, m)); 
    meter = episode(2, m);               % 拍数
    t_play = 0:dt:meter*T-dt;
    
    singleWave = sin(2*pi*freq*t_play);
    secondWave = 0.2*sin(2*pi*(2*freq)*t_play);
    thirdWave = 0.3*sin(2*pi*(3*freq)*t_play);
    combWave = singleWave + secondWave + thirdWave;

    combWave = addEnvelope(f_s, T*meter, combWave, 'exp');
    
    idx_end = idx + meter*T*f_s - 1;  
    Star(idx:idx_end) = combWave;

    idx = idx_end + 1;
end

sound(Star);