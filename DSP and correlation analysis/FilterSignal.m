function FilteredNoisedSignal=FilterSignal(NoisedSignal)
    SpecNoisedSignal = fft(NoisedSignal);
    L = length(SpecNoisedSignal);
    SpecFilter = zeros(1, L);
    SpecFilter(20:end) = 1;
    FilteredSpecSignalHighPass = SpecNoisedSignal .* SpecFilter;
    SpecFilter2 = zeros(1, L);
    SpecFilter2(1:60) = 1;
    FilteredSpecSignalLowPass = FilteredSpecSignalHighPass .* SpecFilter2;
    FilteredNoisedSignal = ifft(FilteredSpecSignalLowPass);

    % Fs = 257;
    % [b, a] = butter(1, [20, 128]/(Fs/2), 'bandpass');
    % FilteredNoisedSignal = filtfilt(b, a, NoisedSignal);
end