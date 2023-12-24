clear all; clc

% Создание двух последовательностей битов
sequence1 = [1 0 1 0 1 1 0 0];
sequence2 = [0 1 0 1 1 0 0 1];

% Инициализация вектора для сохранения значений корреляции
correlation = zeros(1, length(sequence1)-1);

% Вычисление корреляции для каждой задержки
for delay = 0:length(sequence1)-2
    % Сдвиг одной последовательности битов на текущую задержку
    shifted_sequence2 = circshift(sequence2, delay);
    
    % Вычисление корреляции между двумя последовательностями
    correlation(delay+1) = sum(sequence1 .* shifted_sequence2);
end

% Построение графика корреляции от номера бита
plot(0:length(sequence1)-2, correlation);
xlabel('Номер бита');
ylabel('Корреляция');
title('График корреляции от номера бита');
