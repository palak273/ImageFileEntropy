function entEst = collisionEsti(data)
    %data = [1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 0 1 0 1 0 1 1];
    i = 0;
	v = 0;
	s = 0;
    len = length(data);
	while i<len-1
		if data(i+1) == data(i+2)
            t_v = 2; 
        elseif i<len-2
            t_v = 3; 
        else
            break;
        end
		v = v+1;
		s = s+t_v*t_v;
		i = i+t_v;
    end
	X = i/v;
	s = sqrt((s - (i*X)) / (v-1));
	X = X-2.576*s/sqrt(v);
	if X<2.0 
        X = 2.0;
    end
	if X<2.5
		p = 0.5 + sqrt(1.25 - 0.5 * X);
		entEst = -log2(p);
    else
		p = 0.5;
		entEst = 1.0;
    end
end