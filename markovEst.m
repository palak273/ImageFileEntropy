function entEst = markovEst(data)
%data = [1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0];
c0 = 0; c00 = 0; c10 = 0;
for i=1:length(data)-1
    if data(i)==0
        c0 = c0+1;
        if data(i+1)==0
            c00 = c00+1;
        end
    else
        if data(i+1)==0
            c10 = c10+1;
        end
    end
end
c1 = length(data)-1-c0;
if c0>0
    p00 = c00/c0;
    p01 = 1-p00;
else
    p00 = 0;
    p01 = 0;
end
if c1>0
    p10 = c10/c1;
    p11 = 1-p10;
else
    p10 = 0;
    p11 = 0;
end
if data(length(data))==0
    c0=c0+1;
end
p0 = c0/length(data);
p1 = 1-p0;
H_min = 128;
if p00>0
    tmp_min_entropy = -log2(p0) - 127.0*log2(p00); 
    if tmp_min_entropy < H_min
        H_min = tmp_min_entropy;
    end
end
if (p01>0) && (p10>0)
    tmp_min_entropy = -log2(p0) - 64*log2(p01) - 63*log2(p10);
    if tmp_min_entropy<H_min 
        H_min = tmp_min_entropy;
    end
end
if (p01>0)&&(p11>0)
    tmp_min_entropy = -log2(p0) - log2(p01) - 126*log2(p11);
    if tmp_min_entropy<H_min 
        H_min = tmp_min_entropy;
    end
end
if (p10>0) && (p00>0)
    tmp_min_entropy = -log2(p1) - log2(p10) - 126*log2(p00);
    if tmp_min_entropy<H_min
        H_min = tmp_min_entropy;
    end
end
if (p10 > 0.0) && (p01 > 0.0)
    tmp_min_entropy = -log2(p1) - 64*log2(p10) - 63*log2(p01);
    if tmp_min_entropy<H_min 
        H_min = tmp_min_entropy;
    end
end
if(p11>0)
    tmp_min_entropy = -log2(p1) - 127*log2(p11);
    if tmp_min_entropy<H_min
        H_min = tmp_min_entropy;
    end
end
entEst = min(H_min/128,1);
end
    




