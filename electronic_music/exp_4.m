f_s = 8000;     % 8k采样
dt = 1/f_s;
T = 1/4;        % 每拍0.25s

episode = getEpisode('DFH');

DFH = generateMusic(episode, f_s, T, 'exp', 'Norm', true);

sound(DFH);