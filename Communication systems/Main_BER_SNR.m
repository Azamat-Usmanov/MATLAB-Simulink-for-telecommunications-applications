close all; clear; clc;
%% Init parametrs of model
Length_Bit_vector = 1e5;

Constellation = "BPSK"; % QPSK, 8PSK, 16-QAM

SNR = 19; % dB

%% Bit generator

Bit_Tx = randi([0,1], 1, Length_Bit_vector);

%% Mapping
IQ_TX = mapping(Bit_Tx, Constellation);

%% Channel
% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0
Eb_N0 = Eb_N0_convert(SNR, Constellation);
% Use your own function of generating of AWGN from previous tasks
IQ_RX = Noise(IQ_TX, SNR);
hold on
scatter(real(IQ_RX), imag(IQ_RX), 'o', 'blue')
scatter(real(IQ_TX), imag(IQ_TX), 'x', 'red', 'LineWidth', 2)
hold off
grid on
title('Точки созвездия и наложенный шум(' + Constellation + ')')
ylabel('Q')
xlabel('I')
axis([-1.5, 1.5, -1.5, 1.5])

if (Constellation == "QPSK")
    txt1 = '11';
    text(0.85, 0.8, txt1, 'FontSize', 14)
    txt1 = '01';
    text(-0.95, 0.8, txt1, 'FontSize', 14)
    txt1 = '00';
    text(-0.95, -0.85, txt1, 'FontSize', 14)
    txt1 = '10';
    text(0.85, -0.85, txt1, 'FontSize', 14)
elseif (Constellation == "BPSK")
    txt1 = '1';
    text(1.1, 0.25, txt1, 'FontSize', 14)
    txt1 = '0';
    text(-1.15, 0.25, txt1, 'FontSize', 14)
elseif (Constellation == "8PSK")
    txt1 = '010';
    text(-0.1, 1.25, txt1, 'FontSize', 14)
    txt1 = '100';
    text(-0.1, -1.25, txt1, 'FontSize', 14)
    txt1 = '001';
    text(-1.3, 0, txt1, 'FontSize', 14)
    txt1 = '111';
    text(1.2, 0, txt1, 'FontSize', 14)
    txt1 = '000';
    text(-0.9, -0.9, txt1, 'FontSize', 14)
    txt1 = '101';
    text(0.85, -0.85, txt1, 'FontSize', 14)
    txt1 = '110';
    text(0.85, 0.85, txt1, 'FontSize', 14)
    txt1 = '011';
    text(-1, 0.85, txt1, 'FontSize', 14)
elseif (Constellation == "16-QAM")
    txt1 = '0000';
    text(-1.07, 1.25, txt1, 'FontSize', 14)
    txt1 = '0100';
    text(-0.45, 1.25, txt1, 'FontSize', 14)
    txt1 = '1100';
    text(0.2, 1.25, txt1, 'FontSize', 14)
    txt1 = '1000';
    text(0.82, 1.25, txt1, 'FontSize', 14)
    txt1 = '0001';
    text(-1.07, 0.5, txt1, 'FontSize', 14)
    txt1 = '0101';
    text(-0.45, 0.5, txt1, 'FontSize', 14)
    txt1 = '1101';
    text(0.2, 0.5, txt1, 'FontSize', 14)
    txt1 = '1001';
    text(0.82, 0.5, txt1, 'FontSize', 14)
    txt1 = '0011';
    text(-1.07, -0.1, txt1, 'FontSize', 14)
    txt1 = '0111';
    text(-0.45, -0.1, txt1, 'FontSize', 14)
    txt1 = '1111';
    text(0.2, -0.1, txt1, 'FontSize', 14)
    txt1 = '1011';
    text(0.82, -0.1, txt1, 'FontSize', 14)
    txt1 = '0010';
    text(-1.07, -0.75, txt1, 'FontSize', 14)
    txt1 = '0110';
    text(-0.45, -0.75, txt1, 'FontSize', 14)
    txt1 = '1110';
    text(0.2, -0.75, txt1, 'FontSize', 14)
    txt1 = '1010';
    text(0.82, -0.75, txt1, 'FontSize', 14)
end


%% Demapping
Bit_Rx = demapping(IQ_RX, Constellation);

%% Error check
% Write your own function Error_check() for calculation of BER
BER = Error_check(Bit_Tx, Bit_Rx);


%% Additional task. Modulation error ration
MER_estimation = MER_my_func(IQ_RX, Constellation);

% Compare the SNR and MER_estimation from -50dB to +50dB for BPSK, QPSK,
% 8PSK and 16QAM constellation.
% Plot the function of error between SNR and MER for each constellation 
% Discribe the results. Make an conclusion about MER.
% You can use the cycle for collecting of data
% Save figure
SNR_info = zeros(1, 101);
MER_BPSK = zeros(1, 101);
MER_QPSK = zeros(1, 101);
MER_8PSK = zeros(1, 101);
MER_16_QAM = zeros(1, 101);

for i = -50:1:50
    SNR_info(i+51) = i;
    MER_BPSK(i+51) = MER_my_func(Noise(mapping(Bit_Tx, "BPSK"), i), "BPSK");
    MER_QPSK(i+51) = MER_my_func(Noise(mapping(Bit_Tx, "QPSK"), i), "QPSK");
    MER_8PSK(i+51) = MER_my_func(Noise(mapping(Bit_Tx, "8PSK"), i), "8PSK");
    MER_16_QAM(i+51) = MER_my_func(Noise(mapping(Bit_Tx, "16-QAM"), i), "16-QAM");
end
%%
figure
hold on
plot(SNR_info, abs(MER_BPSK-SNR_info), 'LineWidth', 2)
plot(SNR_info, abs(MER_QPSK-SNR_info), 'LineWidth', 2)
plot(SNR_info, abs(MER_8PSK-SNR_info), 'LineWidth', 2)
plot(SNR_info, abs(MER_16_QAM-SNR_info), 'LineWidth', 2)
hold off
grid on
title('Ошибка оценки MER от шума в канале по SNR')
xlabel('SNR (dB)')
ylabel('MER(dB) - SNR(dB)')
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
saveas(gcf, 'MER(SNR)', 'fig')

% Вывод: из результата выполнения кода делаем вывод, что ошибка оценки MER
% увеличивается с увеличением уровня шума в канале(SNR). Чем выше значение
% ошибки оценки MER, тем хуже качество передачи данных в канале.


%% Experimental BER(SNR) and BER(Eb/N0)
% Collect enough data to plot BER(SNR) and BER(Eb/N0) for each
% constellation.
% Compare the constalation. Describe the results
% You can use the cycle for collecting of data
% Save figure

BER_BPSK = zeros(1, 101);
BER_QPSK = zeros(1, 101);
BER_8PSK = zeros(1, 101);
BER_16_QAM = zeros(1, 101);

Eb_N0_BPSK = zeros(1, 101);
Eb_N0_QPSK = zeros(1, 101);
Eb_N0_8PSK = zeros(1, 101);
Eb_N0_16_QAM = zeros(1, 101);

for i = -50:1:50
    BER_BPSK(i+51) = Error_check(Bit_Tx, demapping(Noise(mapping(Bit_Tx, "BPSK"), i), "BPSK"));
    BER_QPSK(i+51) = Error_check(Bit_Tx, demapping(Noise(mapping(Bit_Tx, "QPSK"), i), "QPSK"));
    BER_8PSK(i+51) = Error_check(Bit_Tx, demapping(Noise(mapping(Bit_Tx, "8PSK"), i), "8PSK"));
    BER_16_QAM(i+51) = Error_check(Bit_Tx, demapping(Noise(mapping(Bit_Tx, "16-QAM"), i), "16-QAM"));

    Eb_N0_BPSK(i+51) = Eb_N0_convert(i, "BPSK");
    Eb_N0_QPSK(i+51) = Eb_N0_convert(i, "QPSK");
    Eb_N0_8PSK(i+51) = Eb_N0_convert(i, "8PSK");
    Eb_N0_16_QAM(i+51) = Eb_N0_convert(i, "16-QAM");
end
%%
figure

semilogy(Eb_N0_BPSK, BER_BPSK, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_QPSK, BER_QPSK, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_8PSK, BER_8PSK, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_16_QAM, BER_16_QAM, 'LineWidth', 1.5)
hold off
grid on
title('Зависимость битовой ошибки от величины Eb/N0')
xlabel('Eb/N0(dB)')
ylabel('BER')
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
axis([-20, 20, 10^-3, 1])
hold off
saveas(gcf, 'BER(Eb_N0) experental', 'fig')
%%
figure

semilogy(SNR_info, BER_BPSK, 'LineWidth', 1.5)
hold on
semilogy(SNR_info, BER_QPSK, 'LineWidth', 1.5)
hold on
semilogy(SNR_info, BER_8PSK, 'LineWidth', 1.5)
hold on
semilogy(SNR_info, BER_16_QAM, 'LineWidth', 1.5)
hold off
grid on
title('Зависимость битовой ошибки от величины SNR')
xlabel('SNR(dB)')
ylabel('BER')
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
axis([-20, 20, 10^-3, 1])
saveas(gcf, 'BER(SNR) experental', 'fig')


% Вывод: С увеличением величины Eb/N0 или SNR уровень битовой ошибки (BER) 
% уменьшается для всех типов модуляции.
% Сравнивая графики для разных типов модуляции, можно сказать, что чем больше
% количество фазовых состояний, тем меньше значение BER при 
% одинаковой величине Eb/N0 или SNR. Это означает, что 8PSK и 16-QAM более
% устойчивы к шуму и позволяют достичь более низкого уровня ошибок при передаче данных.
% Поэтому для обеспечения надежной передачи данных необходимо использовать 
% модуляцию с наименьшим уровнем ошибок при заданном уровне шума.

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 8PSK
% and 16QAM constellation
% Save figure

BER_THEOR_BPSK = (1/2).*erfc(sqrt(10.^(Eb_N0_BPSK/10)));
BER_THEOR_QPSK = (1/2).*erfc(sqrt(10.^(Eb_N0_QPSK/10)));
BER_THEOR_8PSK = (2/log2(8))*(1/2).*erfc(sqrt(10.^(Eb_N0_8PSK/10)*log2(8))*sin(pi/8));
BER_THEOR_16_QAM = (4/log2(16))*(1/2).*erfc(sqrt((3*10.^(Eb_N0_16_QAM/10)*log2(16)/(16-1))));

subplot(4, 1, 1)
title('Сравнение теортеческиой с эксперементальной BER(Eb/N0)')
semilogy(Eb_N0_BPSK, BER_THEOR_BPSK, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_BPSK, BER_BPSK, 'LineWidth', 1.5)
hold off
grid on
legend('BPSK theor', 'BPSK exp')
ylabel('BER theor')
xlabel('Eb/N0 (dB)')
axis([0, 15, 10^-5, 1])
subplot(4, 1, 2)
semilogy(Eb_N0_QPSK, BER_THEOR_QPSK, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_QPSK, BER_QPSK, 'LineWidth', 1.5)
hold off
grid on
legend('QPSK theor', 'QPSK exp')
ylabel('BER theor')
xlabel('Eb/N0 (dB)')
axis([0, 15, 10^-5, 1])
subplot(4, 1, 3)
semilogy(Eb_N0_8PSK, BER_THEOR_8PSK, 'LineWidth', 1.5) 
hold on
semilogy(Eb_N0_8PSK, BER_8PSK, 'LineWidth', 1.5)
hold off
grid on
legend('8PSK theor', '8PSK exp')
ylabel('BER theor')
xlabel('Eb/N0 (dB)')
axis([0, 15, 10^-5, 1])
subplot(4, 1, 4)
semilogy(Eb_N0_16_QAM, BER_THEOR_16_QAM, 'LineWidth', 1.5)
hold on
semilogy(Eb_N0_16_QAM, BER_16_QAM, 'LineWidth', 1.5)
hold off
grid on
legend('16-QAM theor', '16-QAM exp')
ylabel('BER theor')
xlabel('Eb/N0 (dB)')
axis([0, 15, 10^-5, 1])
saveas(gcf, 'BER(Eb_N0)theor', 'fig')

% Вывод: Сравнение теоретических и экспериментальных значений BER(Eb/N0)
% позволяет оценить эффективность выбранной модуляции и ее способность 
% обеспечить надежную передачу данных при заданном уровне шума. Если 
% экспериментальные значения BER(Eb/N0) близки к теоретическим, это 
% означает, что выбранная модуляция работает эффективно и обеспечивает 
% низкий уровень ошибок при передаче данных.

