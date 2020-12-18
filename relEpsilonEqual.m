function answ = relEpsilonEqual(A,B,maxAbsFactor,maxRelFactor,maxULP)
    DBL_MIN = realmin;
    if isnan(A) || isnan(B)
        answ = false; return
    end
    if A==B
        answ = true; return
    end
    if isinf(A) || isinf(B)
        answ = false; return
    end
    absA = abs(A);
    absB = abs(B);
    if absA>absB
       %Swap A and B
       tmp = B;
       B = A;
       A = tmp;
       %Swap absA and absB
       tmp = absB;
       absB = absA;
       absA = tmp;
    end
    diff = abs(B-A);
    if (absA<DBL_MIN) || (diff<DBL_MIN) || isinf(diff) || (absB*maxRelFactor<DBL_MIN)
        answ =  (diff<=maxAbsFactor); return
    else
        if diff<=absB*maxRelFactor
            answ = true; return
        end
    end
    if A<0 && B>0 
        answ = false; return
    elseif A>0 && B<0
        answ = false; return
    end
    Aint = typecast(absA,'uint64');
    Bint = typecast(absB,'uint64');
    answ = (Bint-Aint<=maxULP);
end