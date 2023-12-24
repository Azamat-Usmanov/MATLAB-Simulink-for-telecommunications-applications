clear all; clc
load('Matlab_L3_9.mat')

Init_Seed_Gold_1 = [1 1 1 1 0];
Init_Seed_Gold_2 = [0 0 0 0 1];
polynom_Gold_1 = [0 0 1 0 1];
polynom_Gold_2 = [0 1 1 1 1];

polynom_M = [0 0 1 0 1];
Init_Seed_M = [1 1 1 1 0];

m_seq_M = generate_m_sequence(Init_Seed_M, polynom_M);

m_seq1 = generate_m_sequence(Init_Seed_Gold_2, polynom_Gold_2);
m_seq_Gold = double(Cods_Golds(m_seq_M, m_seq1));

% количество заголовков и их позиция
[count_of_header_gold, start_of_frame_position_gold] = Header_count(Bit_Stream_1, m_seq_Gold);
[count_of_header_m, start_of_frame_position_m] = Header_count(Bit_Stream_2, m_seq_M);

%%
% 2 Какой длины кадр данных
Frame_Length_Gold = start_of_frame_position_gold(2) - start_of_frame_position_gold(1);
Frame_Length_M = start_of_frame_position_m(2) - start_of_frame_position_m(1);


%%
% 1 Какой длины блок данных
Data_Length_Golds = Frame_Length_Gold - length(m_seq_Gold);
Data_Length_M = Frame_Length_M - length(m_seq_M);

%%
% 3 С какой позиции начинается следующий целый кадр
Start_Of_Frame_Position_Gold = start_of_frame_position_gold;
Start_Of_Frame_Position_M = start_of_frame_position_m;

%%
% 4 Какой количество кадров в предоставленной последовательности
Number_Of_Frames_Gold = count_of_header_gold + 1;
Number_Of_Frames_M = count_of_header_m + 1;

%%
% 5 Построить график корреляции от номера бита и сохранить его в файл Frame_Corr.fig

crossCorrGold = xcorr(m_seq_Gold, Bit_Stream_1);
crossCorrM = xcorr(m_seq_M, Bit_Stream_2);
subplot(2, 1, 1)
plot(crossCorrGold/max(crossCorrGold))
title('Корреляция для сигнала Bit Stream 1')
xlabel('Смещение')
ylabel('Корреляция')
grid("on")
axis([0, 80679, 0, 1])

subplot(2, 1, 2)
plot(crossCorrM/max(crossCorrM))
title('Корреляция для сигнала Bit Stream 2')
xlabel('Смещение')
ylabel('Корреляция')
grid("on")
axis([0, 78568, 0, 1])

savefig('Frame_Corr.fig');

%%
% 6 Автокорреляция
corr_m_seq_Gold = xcorr(m_seq_Gold, 'unbiased');
corr_m_seq_M = xcorr(m_seq_M, 'unbiased');
figure
subplot(2, 1, 1)
plot(corr_m_seq_Gold)
title("Автокорреляция последовательнсти Кодов Голда")
xlabel("Временной сдвиг")
ylabel('Корреляция')
grid("on")
% axis([22, 234, 0, 1])
subplot(2, 1, 2)
plot(corr_m_seq_M)
title("Автокорреляция m-последовательнсти")
xlabel("Временной сдвиг")
ylabel('Корреляция')
grid("on")
% axis([22, 232, 0, 1])
saveas(gcf, 'AutoCorr', 'fig')

PN_Period = 2.^5 - 1;


l = M_Sequence(polynom_M, Init_Seed_M, 128);

%%
% Фунция подсчета заголовков
function [count_of_header, start_of_frame_position] = Header_count(Bit_Stream, m_seq)
    count_of_header = 0;
    start_of_frame_position = [];
    for itter = 1:length(Bit_Stream) - 127
        if m_seq(1:128) == Bit_Stream(itter:127+itter)
            start_of_frame_position(count_of_header + 1) = itter;
            count_of_header = count_of_header + 1;
        end
    end
end

% Генерация последовательности Кода Голда
function m_seq = Cods_Golds(m_seq1, m_seq2)
    m_seq = xor(m_seq1, m_seq2);
end

% Генерация M-последовательности
function m_sequence = generate_m_sequence(init_seed, polynomial)
    % Создание пустого массива для хранения M-последовательности
    m_sequence = zeros(1, 128);

    % Инициализация состояния генератора
    current_state = init_seed;

    % Генерация M-последовательности с помощью регистра сдвига
    for i = 1:128
        m_sequence(i) = current_state(end);

        % Вычисление нового состояния генератора
        new_state = mod(sum(polynomial .* current_state), 2);

        % Сдвиг состояния генератора вправо
        current_state = [new_state, current_state(1:end-1)];
    end
end


function FinalSequence = M_Sequence(InitPolynomial, InitSeedM, NumberOfItter)

    FinalSequence = zeros(1, NumberOfItter);
    TempPolynomial = InitSeedM;

    for itter1 = 1:NumberOfItter

        FinalSequence(itter1) = TempPolynomial(end);
        NewFirstReg = mod(sum(TempPolynomial .* InitPolynomial), 2);
        TempPolynomial = [NewFirstReg, TempPolynomial(1:end-1)];

    end

end