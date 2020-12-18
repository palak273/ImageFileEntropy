clc
clear all
X = double(imread('peppers.png'));
data = X(:);
[counts, centers] = hist(data);
pbar = max(counts)/length(data);
c1 = pbar*(1-pbar);
c2 = length(data)-1;
c3 = sqrt(c1/c2);
c4 = pbar+2.576*c3; 
pu = min(1,c4);
min_entropy = -log2(pu)