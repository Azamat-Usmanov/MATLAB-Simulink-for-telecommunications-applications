function average_power=PowerSignal(Signal)
    average_power = mean(abs(Signal).^2);
end