function ema = ema(currentSample, period, data)
    alpha = 1 - (2/(period + 1));
    nominator = 0;
    denominator = 0;

    for t = 0:period
        if (currentSample - t) < 1
            continue;
        end
        nominator = nominator + data(currentSample - t) * power(alpha, t);
        denominator = denominator + power(alpha, t);
    end
    ema = nominator./denominator;
    
end

