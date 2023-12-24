function NoisedSignal = NoiseGenerator(SNR, Signal)
    signal_power = PowerSignal(Signal);
    N_real = normrnd(0, sqrt(signal_power*10.^(-(SNR/10))/2), size(Signal));
    N_imag = normrnd(0, sqrt(signal_power*10.^(-(SNR/10))/2), size(Signal));
    Noise = N_real + 1j .* N_imag;
    NoisedSignal = Signal + Noise;

    % SNR(dB) = 10lg(P(Signal)/P(Noise))
    % SNR(dB) = 10lg(P(Signal)) - 10lg(P(Noise))
    % lg(P(Noise)) = lg(P(Signal)) - SNR(db)/10
    % P(Noise) = P(Signal)*10^(-(SNR(dB)/10))
end