function ans = G(z,d,num_blocks)
    Ai = 0; Ai_comp = 0;
    firstSum = 0; firstSum_comp = 0;
    v = num_blocks-d;
    Bterm = 1-z;
    Bi = Bterm;
    for i = 2:d
        %kahan_add(Ai,Ai_comp,log2(i)*Bi);
        y = log2(i)*Bi-Ai_comp;
        t = Ai+y;
        Ai_comp = (t-Ai)-y;
        Ai = t;
        Bi = Bi*Bterm;
    end
    Ad1 = Ai; underflowTruncate = false;
    for i = d+1:num_blocks-1
        ai = log2(i)*Bi;
        %kahan_add(Ai,Ai_comp,ai);
        y = ai-Ai_comp;
        t = Ai+y;
        Ai_comp = (t-Ai)-y;
        Ai = t;
        aiScaled = (num_blocks-i)*ai;
        if(aiScaled>0)
            %kahan_add(firstSum,firstSum_comp,aiScaled);
            y = aiScaled-firstSum_comp;
            t = firstSum+y;
            firstSum_comp = (t-firstSum)-y;
            firstSum = t;
        else
            underflowTruncate = true; break;
        end
        Bi = Bi*Bterm;
    end
    %kahan_add(firstSum,firstSum_comp,(num_blocks-d)*Ad1);
    y = (num_blocks-d)*Ad1-firstSum_comp;
    t = firstSum+y;
    firstSum_comp = (t-firstSum)-y;
    firstSum = t;
    if underflowTruncate==false
        ai = log2(num_blocks)*Bi;
        %kahan_add(Ai,Ai_comp,ai);
        y = ai-Ai_comp;
        t = Ai+y;
        Ai_comp = (t-Ai)-y;
        Ai = t;
    end
    ans = 1/v*z*(z*firstSum+(Ai-Ad1));
end
