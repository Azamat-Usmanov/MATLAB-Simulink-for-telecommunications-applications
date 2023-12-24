function h = my_autocorr(M_Sequences)
    m_seq_new = (M_Sequences(1:end-4) - 0.5)*2;
    len = length(M_Sequences);
    
    h = zeros(1, len);
    
    for i = 1:len-4
        h(i) = sum(circshift(m_seq_new, i) .* m_seq_new);
    end
end
