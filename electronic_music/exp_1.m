clear all, close all, clc;

f_s = 8000;     % 8k采样
T = 1/2;        % 每拍0.5s

episode = getEpisode('DFHSlice');
DFH = generateMusic(episode, f_s, T, 'None', 'Norm', false);

plot(DFH)
sound(DFH);