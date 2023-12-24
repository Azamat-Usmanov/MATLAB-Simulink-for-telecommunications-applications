clear all; clc;

% Считываем аудиофайл
filename = 'A.wav';
[y, Fs] = audioread(filename);

% задаем оконную функцию Хэмминга
hamming_window = hamming(length(y));

% применяем оконную функцию к голосовым связкам
y_weighted = y.* hamming_window;

% применение фильтра низких частот для удаления высокочастотных шумов
cutoff_frequency = 500;
[b, a] = butter(4, cutoff_frequency/(Fs/2), 'low');
y_filtered = filter(b, a, y_weighted);

% вычисление логарифма модуля спектра
N = length(y_filtered);
Y = fft(y_filtered);
Y_mag = abs(Y(1:N/2+1));
Y_mag_log = 20*log10(Y_mag);
f = Fs*(0:(N/2))/N;

% нахождение формант
formants = [];
for i=1:5
    [~,idx] = max(Y_mag_log);
    formants = [formants f(idx)];
    Y_mag_log(max(1,idx-20):min(length(Y_mag_log),idx+20)) = -Inf;
end

% вывод результатов
disp('Частота основного тона: ');
disp(formants(1));

disp('Найденные форманты:');
disp(formants);


% выводим результаты
set(gcf, 'position', [180, 80, 880, 580])
subplot(2, 1, 1);
plot(y_filtered);
title('Отфильтрованный сигнал');
xlabel('Время, с');
ylabel('Амплитуда');
grid("on")
subplot(2, 1, 2)
plot(f,Y_mag_log)
title('Логарифм модуля спектра')
xlabel('Частота, Гц')
ylabel('Амплитуда')
grid("on")

saveas(gcf, 'logspec', 'png')

% Вывод
% Оконное взвешивание используется для уменьшения эффекта "разрезания" сигнала 
% при его разбиении на фрагменты для анализа. Оконная функция, такая как окно Хэмминга, 
% уменьшает амплитуду сигнала на краях окна, чтобы сгладить его переходы к нулю.
% 
% Окно Хэмминга было выбрано из-за своих хороших характеристик, таких как широкий 
% динамический диапазон и низкий уровень боковых лепестков.
