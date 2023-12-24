function [Bit] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation
[Dictionary, ~] = constellation_func(Constellation);

% write  the function of mapping from IQ vector to bit vector
h = Dictionary.values.';

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

switch Constellation
    case "BPSK"
        Dictionary_demapping = dictionary(Dictionary.values, Dictionary.keys);
    case "QPSK"
        Dictionary_demapping = dictionary(Dictionary.values, Dictionary.keys);
    case "8PSK"
        Dictionary_demapping = dictionary(Dictionary.values, Dictionary.keys);
    case "16-QAM"
        Dictionary_demapping = dictionary(Dictionary.values, Dictionary.keys);
end

Bit = cell2mat(Dictionary_demapping(IQ_RX_constellation(1)));

for i = 2:length(IQ_RX_constellation)
    Bit = [Bit, cell2mat(Dictionary_demapping(IQ_RX_constellation(i)))]; 
end


end

