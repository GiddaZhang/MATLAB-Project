function y = getFreq_5(sound_name)
    if sound_name == -1
        y = 493.88/2^(1/4);
    elseif sound_name == 1
        y = 493.88;
    elseif sound_name == 2
        y = 493.88*2^(1/6);
    elseif sound_name == 3
        y = 493.88*2^(1/3);
    elseif sound_name == 4
        y = 493.88*2^(1/3+1/12);
    elseif sound_name == 5
        y = 493.88*2^(1/3+1/4);
    else
        y = 0;
    end
end