function [BER] = Error_check(Bit_Tx, Bit_Rx)
    if (mod(length(Bit_Rx), 2) ~= 0); Bit_Tx = Bit_Tx(1:end-1); end
    BER = (length(Bit_Tx)-sum(Bit_Rx == Bit_Tx))/length(Bit_Tx);
end

