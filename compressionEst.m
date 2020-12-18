function entEst = compressionEst(data)
    RELEPSILON = 2.2204460492503131e-16;
    ABSEPSILON = realmin;
    b = 6;
    d = 4;
    num_blocks = length(data)/b;
    X = 0; X_comp =0; sigma = 0; sigma_comp = 0;
    if num_blocks<=d
        disp('Not enough samples');
        entEst = -1;
    end
    alph_size = bitshift(1,b);
    for i = 1:alph_size 
        dict(i) = 0;
    end
    for i = 0:d-1
        block = 0;
        for j = 0:b-1
            block = bitor(block,bitshift(bitand(data(i*b+j+1),1),(b-j-1)));
        end
        dict(block+1) = i+1;
    end
    v = num_blocks-d;
    for i = d:num_blocks-1
        block = 0;
        for j = 0:b-1
            block = bitor(block,bitshift(bitand(data(i*b+j+1),1),(b-j-1)));
        end
        %kahan_add(X,X_comp,log2(i+1-dict(block)));
        y = log2(i+1-dict(block+1)) - X_comp;
        t = X+y;
        X_comp = (t-X)-y;
        X = t;
        %kahan_add(sigma,sigma_comp,log2(i+1-dict(block))*log2(i+1-dict(block)));
        y = log2(i+1-dict(block+1))*log2(i+1-dict(block+1));
        t = sigma+y;
        sigma_comp = (t-sigma)-y;
        sigma = t;
        dict(block+1) = i+1;
    end
    X = X/v;
    sigma = 0.5907*sqrt(sigma/(v-1)-X*X);
    X = X-(2.576*sigma)/sqrt(v);
    if comp_exp(1/alph_size,alph_size,d,num_blocks)>X
        ldomain = 1/alph_size; hdomain = 1;
        lbound = ldomain; hbound = hdomain;
        lvalue = realmax; hvalue = -realmax;
        p = (lbound+hbound)/2;
        pVal = comp_exp(p,alph_size,d,num_blocks);
        for j=1:1076
            if relEpsilonEqual(pVal,X,ABSEPSILON,RELEPSILON,4)==true
                break;
            end
            if X<pVal 
                lbound = p; lvalue = pVal;
            else
                hbound = p; hvalue = pVal;
            end
            if lbound>=hbound
                p = min(max(lbound,hbound),hdomain); break;
            end
            if inClosedInterval(lbound,ldomain,hdomain)==false && inClosedInterval(hbound,ldomain,hdomain)==true
                p = ldomain; break;
            end
            if inClosedInterval(X,lvalue,hvalue)==false
                p = ldomain; break;
            end
            lastP = p;
            p = (lbound+hbound)/2;
            if inOpenInterval(p,lbound,hbound)==false
                p = hbound; break;
            end
            if lastP==p
                p = hbound; break;
            end
            pVal = comp_exp(p,alph_size,d,num_blocks);
            if inClosedInterval(pVal,lvalue,hvalue)==false
                p = hbound; break;
            end
        end
    else
        p = -1;
    end
    if p>1/alph_size
        entEst = -log2(p)/b;
    else
        p = 1/alph_size;
        entEst = 1;
    end
end