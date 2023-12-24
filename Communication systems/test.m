clear all; clc

%%
Length_Bit_vector = 1e5;
Bit_Tx = randi([0,1], 1, Length_Bit_vector);
%%
Constellation = "8-PSK"; % QPSK, 8PSK, 16-QAM

SNR = 20; % dB

IQ_TX = mapping(Bit_Tx, Constellation);
IQ_RX = Noise(IQ_TX, SNR);

scatter(real(IQ_RX), imag(IQ_RX))

[d, b] = constellation_func(Constellation);

h = d.values.';

IQ_RX_constellation = zeros(1, length(IQ_RX));

for i = 1:length(IQ_RX)
    min_h = abs(h(1) - IQ_RX(i));
    IQ_RX_constellation(i) = h(1);
    for j = 2:length(h)
        if (abs(h(j) - IQ_RX(i)) < min_h)
            min_h = abs(h(j) - IQ_RX(i));
            IQ_RX_constellation(i) = h(j);
        end
    end
end


%%
N = 4;
% keys = [-1 - 1*1j
%         -1 + 1*1j
%          1 - 1*1j
%          1 + 1*1j];
% values = {[0 0]
%           [0 1]
%           [1 0]
%           [1 1]};
[d, b] = constellation_func("QPSK");
Dictionary_demapping = dictionary(d.values, d.keys);

norm = sqrt(sum(Dictionary_demapping.keys .* conj(Dictionary_demapping.keys))/N);
% Dictionary_demapping = Dictionary_demapping/norm;

%%
g = 0;

for i = 1:50
    g = [g, [1 0]];
end

%%
[d, b] = constellation_func("QPSK");
Dictionary_demapping = dictionary(d.values, d.keys);

Bit = cell2mat(Dictionary_demapping(IQ_RX_constellation(1)));

for i = 2:length(IQ_RX_constellation)
    Bit = [Bit, cell2mat(Dictionary_demapping(IQ_RX_constellation(i)))]; 
end

%%
[d, b] = constellation_func("QPSK");
% sum_tx_constellation = sum(abs(d.values).^2);

sum_deviation_constellation = sum(abs(IQ_RX).^2);
%%
