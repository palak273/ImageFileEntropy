function min_entropy_MCV = mostCommonValueEst(data)
    %data = [0 1 1 2 0 1 2 2 0 1 0 1 1 0 2 2 1 0 2 1]
    [counts, centers] = hist(data);
    pbar = max(counts)/length(data);
    c1 = pbar*(1-pbar);
    c2 = length(data)-1;
    c3 = sqrt(c1/c2);
    c4 = pbar+2.576*c3; 
    pu = min(1,c4);
    min_entropy_MCV = -log2(pu);
end