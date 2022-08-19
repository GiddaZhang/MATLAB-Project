function envelopedWave = addEnvelope(f_s, T, wave, type)
    
    % 可选择线性、指数型包络
    dt = 1/f_s;
    t = 0:dt:T-dt;

    t_delta = t(1:0.2*length(t));
    t_decay = t(1:0.15*length(t));
    t_hold = t(1:0.35*length(t));
    t_disappear = t(1:0.3*length(t));

    if strcmp(type, 'linear')

        f_delta = 1.4/(0.2*T)*t_delta;
        f_decay = -0.4/(0.15*T)*t_decay + 1.4;
        t_hold(1,:) = 1;
        f_hold = t_hold;
        f_disappear = -1/(0.3*T)*t_disappear + 1;

        envelope = [f_delta, f_decay, f_hold, f_disappear];
        envelopedWave = envelope.*wave;
    
    elseif strcmp(type, 'exp')

        f_delta = 0.01*(140^(5/T)).^t_delta;
        f_decay = 1.4*(1/1.4)^(1/(0.15*T)).^t_decay;
        t_hold(1,:) = 1;
        f_hold = t_hold;
        f_disappear = (0.01^(1/(0.3*T))).^t_disappear;

        envelope = [f_delta, f_decay, f_hold, f_disappear];
        envelopedWave = envelope.*wave;

    elseif strcmp(type, 'guitar')
%         t_disappear = t(1:0.8*length(t));
%         f_delta = 1.2/(0.2*T)*t_delta;
%         f_disappear = 1.2*(0.01/1.2)^(1/T/0.8).^t_disappear;
%         envelope = [f_delta, f_disappear];
        envelope = 1.2*(0.01/1.2)^(1/T).^t;
        envelopedWave = envelope.*wave;

    else 
        envelopedWave = wave;
    end
    
end