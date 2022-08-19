function music = generateMusic(episode, f_s, T, env, tune, harmonic)

    % 根据episode参数、采样率参数、每拍持续时间参数、是否添加包络
    % 返回可播放音乐片段

    % 初始化
    len_music = sum(episode(2,:))*f_s*T;
    len_episode = length(episode);
    music = zeros(1, len_music);
    dt = 1/f_s;

    idx = 1;

    for m = 1:len_episode

        if strcmp(tune, 'Norm') || strcmp(tune, 'HigherHalf')
            freq = getFreq(episode(1, m)); 
        else 
            freq = getFreq(episode(1, m), tune); 
        end

        meter = episode(2, m);               % 拍数
        t_play = 0:dt:meter*T-dt;
        if harmonic == false
            Wave = sin(2*pi*freq*t_play);
        else
            Wave = sin(2*pi*freq*t_play) + 0.2*sin(2*pi*(2*freq)*t_play) + 0.3*sin(2*pi*(3*freq)*t_play);
        end

        Wave = addEnvelope(f_s, meter*T, Wave, env);
    
        idx_begin = idx;
        idx_end = idx_begin + meter*T*f_s - 1; 
        music(idx_begin:idx_end) = Wave;
    
        idx = idx_end + 1;
    end
    
    if strcmp(tune, 'HigherHalf')
        music = resample(music, 10000, 10595);  % 减小采样率，相当于提高播放速度，即提高频率
    end
end