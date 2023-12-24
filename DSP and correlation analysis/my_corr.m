function h = my_corr(M_Sequences1, M_Sequences2)
    m_seq_new1 = (M_Sequences1(1:end) - 0.5)*2;
    m_seq_new2 = (M_Sequences2(1:end) - 0.5)*2;
    len = length(M_Sequences1);
    
    h = zeros(1, len);
    
    for i = 1:len
        h(i) = sum(circshift(m_seq_new1, i) .* m_seq_new2);
    end
end

