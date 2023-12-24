function [IQ] = mapping(Bit_Tx, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations

% calculate the Bit_depth for each contellation

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

% write  the function of mapping from bit vector to IQ vector

counter = 1;

K = round(length(Bit_Tx)/Bit_depth_Dict);


for i = 1:Bit_depth_Dict:K*Bit_depth_Dict
    IQ(counter) = Dictionary({Bit_Tx(i:i + Bit_depth_Dict - 1)});
    counter = counter + 1;
end


end

