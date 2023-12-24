clear all; clc

%% 1 Fouirer trnsform
S(20) = 2;
S(40) = 3;
S(60) = 1;
S(61:128) = 0;

Signal = ifft(S);
t = linspace(0, 1, length(S));

set(gcf, 'position', [400, 200, 680, 480])
plot(t, abs(Signal), "LineWidth", 2)
title("Signal")
xlabel('Time')
ylabel('Amplitude')
grid("on")


%% 2 Noise generation

SNR = 10;
NoisedSignal = NoiseGenerator(SNR, Signal);

figure
set(gcf, 'position', [400, 200, 680, 480])
plot(t, abs(NoisedSignal), "LineWidth", 2)
title("Signal + Noise")
xlabel('Time')
ylabel('Amplitude')
grid("on")

%% 3 Powers of signals

P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(NoisedSignal - Signal);
P_NoisedSignal = PowerSignal(NoisedSignal);

%% 4 Parseval theorem

SignalSpec = fft(Signal);
NoiseSpec = fft(NoisedSignal - Signal);
NoisedSignalSpec = fft(NoisedSignal);

P_SignalSpec = PowerSignal(SignalSpec)/length(SignalSpec);
P_NoiseSpec = PowerSignal(NoiseSpec)/length(NoiseSpec);
P_NoisedSignalSpec = PowerSignal(NoisedSignalSpec)/length(NoisedSignalSpec);

if abs(P_SignalSpec - P_Signal)/P_Signal < 0.001
    disp('True')
else
    disp('False')
end

if abs(P_Noise - P_NoiseSpec)/P_Noise < 0.001
    disp('True')
else
    disp('False')
end

if abs(P_NoisedSignal - P_NoisedSignalSpec)/P_NoisedSignal < 0.001
    disp('True')
else
    disp('False')
end

figure
subplot(3, 1, 1)
set(gcf, 'position', [400, 200, 680, 480])
plot(abs(SignalSpec), "LineWidth", 1.5)
title('Spectrum Signal')
xlabel('Frequency')
ylabel('Amplitude')
grid("on")
subplot(3, 1, 2)
plot(abs(NoiseSpec), 'LineWidth', 1.5)
title('Spectrum Noise')
xlabel('Frequency')
ylabel('Amplitude')
grid("on")
subplot(3, 1, 3)
plot(abs(NoisedSignalSpec), 'LineWidth', 1.5)
title('Spectrum NoisedSignal')
xlabel('Frequency')
ylabel('Amplitude')
grid("on")
    
%% 5 Signal filtering

FilteredNoisedSignal = FilterSignal(NoisedSignal);

FilterSignalSpec = fft(FilteredNoisedSignal);

figure
set(gcf, 'position', [400, 200, 680, 480])
subplot(2, 1, 1)
plot(abs(NoisedSignalSpec), "LineWidth", 1.5)
title('Spectrum NoisedSignal')
xlabel('Frequency')
ylabel('Amplitude')
grid("on")
subplot(2, 1, 2)
plot(abs(FilterSignalSpec), "LineWidth", 1.5)
title('Spectrum FilteredNoisedSignal')
xlabel('Frequency')
ylabel('Amplitude')
grid("on")

%% 6 SNR comparsion

SNR_NoisedSignal = 10*log10(P_Signal/P_Noise);
SNR_FilteredNoisedSignal = 10*log10(P_Signal/PowerSignal(FilteredNoisedSignal - Signal));


disp("ОСШ до фильрации: ")
disp(SNR_NoisedSignal)
disp("ОСШ после фильтрации: ")
disp(SNR_FilteredNoisedSignal)

disp("Чем больше ОСШ, тем меньше шум влияет на характеристики системы")
disp("Выигрышь ОСШ на: ")
disp(SNR_FilteredNoisedSignal - SNR_NoisedSignal)
disp("Видим что филтрованный сигнал дает больше ОСШ, чем сигнал до фильтрации." + ...
    " Значит шум меньше влияет на наш сигнал")
disp("Обратное не может быть, так как чем больше мощность шума тем меньше ОСШ")


