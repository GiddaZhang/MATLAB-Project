clear;
realWave = audioread("fmt.wav");      % wavread函数已删除
f_s = 8000;

[y, f, tune] = getFreqAndDistri(realWave,'n');
rhythm = getRhythm();
disp(char(tune));