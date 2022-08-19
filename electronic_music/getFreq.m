function y = getFreq(sound_name, varargin)
% 1=F2/4: 5-C, 6-D, 2-G, 1-F, -1-D_bass
% f_C = 523.25;
% f_F = 349.23;
% f_G = 392;
% f_D = 587.33;
%f_A = 440;
    if nargin == 1
        if sound_name == 5
            y = 523.25;
        elseif sound_name == 1
            y = 349.23;
        elseif sound_name == 8
            y = 349.23*2;
        elseif sound_name == 2
            y = 392;
        elseif sound_name == 3
            y = 392;
        elseif sound_name == 6
            y = 587.33;    
        elseif sound_name == -1
            y = 587.33/2;
        elseif sound_name == -2
            y = 523.25/2;
        elseif sound_name == 0
            y = 329.63;
        else
            y = 0;
        end
    end
    
    if nargin == 2
        if strcmp(varargin{1}, 'Higher8')
            y = getFreq(sound_name)*2;
        elseif strcmp(varargin{1}, 'Lower8')
            y = getFreq(sound_name)/2;
        else
            y = 0;
        end
    end
end