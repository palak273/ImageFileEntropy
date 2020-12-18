function ans = comp_exp(p,alph_size,d,num_blocks)
    q = (1-p)/(alph_size-1);
    ans = G(p,d,num_blocks)+(alph_size-1)*G(q,d,num_blocks);
end
