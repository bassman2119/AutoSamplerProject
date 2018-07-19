function res = L2_vecNorm(X)
S1 = size(X);
S2 = size(S1);
last = 1;
for i= 1:S2(2)
last = last*S1(i);

end

res = 0;

    for i = 1:last
        res = res + abs(X(i))^2;
    end
    
    res = res^(1/2);   %res = Sum of each individual element of X squared, the whole in the root

end