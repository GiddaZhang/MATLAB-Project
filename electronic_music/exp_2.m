clear all, close all, clc;

f_s = 8000;     % 8k采样
dt = 1/f_s;
T = 1/2;        % 每拍0.5s

episode = getEpisode('DFHSlice');
% DFH = generateMusic(episode, f_s, T, 'linear', 'Norm', false);
DFH = generateMusic(episode, f_s, T, 'exp', 'Norm', false);


sound(DFH);