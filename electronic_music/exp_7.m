load("Guitar.MAT");
f_s = 8000;
dt = 1/f_s;
idx = 0:dt:dt*length(realwave)-dt;

subplot(3, 1, 1);
plot(idx, realwave, 'red');
title('realwave');

subplot(3, 1, 2);
plot(idx, wave2proc, 'blue');
title('wave2proc');

newwave = resample(realwave, 250, 243);     % resample to 250, each period 25
onePeriod = zeros(25, 1);
for m = 1:25
    for n = 0:9
        onePeriod(m) = onePeriod(m) + newwave(m + n*25);
    end
    onePeriod(m) = onePeriod(m)/10;
end
tenPeriod = repmat(onePeriod, 10, 1);
finalResult = resample(tenPeriod, 243, 250);

subplot(3, 1, 3);
plot(idx, finalResult, 'green');
title('newwave');