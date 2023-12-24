function [MER] = MER_my_func(IQ_RX, Constellation)
    [Dictionary, ~] = constellation_func(Constellation);

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


    sum_tx_constellation = sum(abs(IQ_RX_constellation).^2);
    sum_deviation_constellation = sum(abs(IQ_RX_constellation - IQ_RX).^2);
    MER = 10*log10(sum_tx_constellation/sum_deviation_constellation);
end

