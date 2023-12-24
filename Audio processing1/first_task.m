%% Задача 1
clear all; clc;

% Считываем аудиофайл
filename = 'file8.wav';
[x, Fs] = audioread(filename);

T = 1/Fs;
t = (0:length(x)-1)*T;

% Делаем бсытрое преобразован
% ъие Фурье
N = length(x);
X = fft(x);
X = circshift (X, round(length(X)/2));
f = Fs/N*(0:N/2);

% Ищем частоты поврежденных гармоника
[HarmAmp, HarmInd] = maxk (abs (X((round(length(X)/2)):(length(X)))), 3);
HarmFrequences = HarmInd - 2;

first_frequency = ['Частота первой гармоники: ', num2str(HarmFrequences(3))];
second_frequency = ['Частота второй гармоники: ', num2str(HarmFrequences(2))];
third_frequency = ['Частота третьей гармоники: ', num2str(HarmFrequences(1))];

disp(first_frequency);
disp(second_frequency);
disp(third_frequency);

% Филтрация сигнала
AudioFilter = FilterSignal(x, HarmFrequences(end:-1:1), Fs);
SpecAudioFilter = fft(AudioFilter);
SpecAudioFilter = circshift (SpecAudioFilter, round(length(SpecAudioFilter)/2));


% График изначального сигнала, спектр сигнала и отфильтрованного сигнала
set(gcf, 'position', [180, 80, 880, 580])
grid("on")
subplot(3,1,1)
plot(t, x, "LineWidth", 0.3);
title("Изначальный сигнал")
xlabel('Время')
ylabel('Амплитуда')
grid("on")

subplot(3,1,2)
plot(abs(X),"LineWidth",3) 
title("Спектр сигнала")
xlabel("Частота (Hz)")
ylabel("Амплитуда")
grid("on")

subplot(3,1,3)
plot(abs(SpecAudioFilter), "LineWidth", 3);
title("Спектр отфильтрованного сигнала")
xlabel('Частота (Hz)')
ylabel('Амплитуда')
grid("on")

saveas(gcf, 'task1', 'png')
%%
figure
plot(ifft(SpecAudioFilter))
%%
function FilteredSignal = FilterSignal (Signal, HarmonicFrequences, Fs)
    SignalSpec = fft (Signal);
    W = zeros (length (SignalSpec));
    W(round (HarmonicFrequences) + 1) = 1;
    W(round (Fs) - round (HarmonicFrequences) + 1) = 1;
    FilteredSignalSpec = W .* SignalSpec;
    FilteredSignal = ifft (FilteredSignalSpec);
end

% Отрицательные частоты возникают из-за применения преобразования Фурье к
% сигналу, который не является переодитечским. Преобразование Фурье
% позволяет разложить сигнал на состовляющие частоты, но оно предполагает,
% что сигнал является периодическим.