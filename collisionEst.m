function min_entropy_collision = collisionEst(data)
    %data = [1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1];
    v = 0;
    index = 1;
    while index<=length(data)
        if data(index)==0
            c0 = 1; c1 = 0;
        else
            c0 = 0; c1 = 1;
        end
        j = index+1;
        while j<=length(data)
            sj = data(j);
            if sj==0
                c0 = c0+1;
            else
                c1 = c1+1;
            end
            if c0>1 || c1>1
                break
            end
            j = j+1;
        end
        v = v+1; t(v) = j-index+1; index = j+1;
    end
    xbar = mean(t);
    stdev = std(t);
    xd = xbar - 2.576*(stdev/sqrt(v));
    if xd>=2 && xd<=2.5
        p = (1+sqrt(5-2*xd))/2;
        min_entropy_collision = -log2(p);
    else
        min_entropy_collision = 1;
    end
end
    









