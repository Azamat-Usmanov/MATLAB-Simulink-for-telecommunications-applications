function [Dictionary, Bit_depth_Dict] = constellation_func(Constellation)
    switch Constellation
        case "BPSK"
            N = 2;
            keys = {[0] 
                    [1]};
            values = [-1 + 0*1j
                      1 + 0*1j];
            Dictionary = dictionary(keys, values);
            Bit_depth_Dict = log2(N);
        case "QPSK"
            N = 4;
            keys = {[0 0]
                   [0 1]
                   [1 0]
                   [1 1] };
            values = [-1 - 1*1j
                     -1 + 1*1j
                      1 - 1*1j
                      1 + 1*1j];
            Dictionary = dictionary(keys, values);
            Bit_depth_Dict = log2(N);
        case "8PSK"
            N = 8;
            keys = {[0 0 0]
                   [0 0 1]
                   [0 1 0]
                   [0 1 1]
                   [1 0 0]
                   [1 0 1]
                   [1 1 0]
                   [1 1 1] };
            values = [-1/sqrt(2) - 1j*1/sqrt(2)
                      -1 + 0*1j
                      0 + 1*1j
                      -1/sqrt(2) + 1j*1/sqrt(2)
                      0 - 1*1j
                      1/sqrt(2) - 1j*1/sqrt(2)
                      1/sqrt(2) + 1j*1/sqrt(2)
                      1 + 0*1j ];
            Dictionary = dictionary(keys, values);
            Bit_depth_Dict = log2(N);
        case "16-QAM"
            N = 16;
            keys = {[0 0 0 0]
                   [0 0 0 1]
                   [0 0 1 0]
                   [0 0 1 1]
                   [0 1 0 0]
                   [0 1 0 1]
                   [0 1 1 0]
                   [0 1 1 1] 
                   [1 0 0 0]
                   [1 0 0 1]
                   [1 0 1 0]
                   [1 0 1 1]
                   [1 1 0 0]
                   [1 1 0 1]
                   [1 1 1 0]
                   [1 1 1 1]};
            values = [-3 + 1j*3
                      -3 + 1j*1
                      -3 - 1j*3
                      -3 - 1j*1
                      -1 + 1j*3
                      -1 + 1j*1
                      -1 - 1j*3
                      -1 - 1j*1
                       3 + 1j*3
                       3 + 1j*1
                       3 - 1j*3
                       3 - 1j*1
                       1 + 1j*3
                       1 + 1j*1
                       1 - 1j*3
                       1 - 1j*1];
            Dictionary = dictionary(keys, values);
            Bit_depth_Dict = log2(N);
    end
    
    % Normalise the constellation.
    % Mean power of every constellation must be equel 1.
    % Make the function to calculate the norm, 
    % which can be applied for every constellation
    norm = sqrt(sum(Dictionary.values .* conj(Dictionary.values))/N);
    Dictionary(Dictionary.keys) = Dictionary(Dictionary.keys)/norm;

end

