function [Eb_N0] = Eb_N0_convert(SNR, Constellation)
    [~, Bit_depth_Dict] = constellation_func(Constellation);
    Eb_N0 = SNR - 10*log10(Bit_depth_Dict);
end

