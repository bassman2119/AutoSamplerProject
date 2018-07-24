function res = L2_vecNorm(X)
S1 = size(X);       % "S1" is a 1xn vector which indicates the number elements per dimension of "X" ("X" element of R^n). 
S2 = size(S1);      % "S2" is a 1x2 vector which indicates the numper of rows and collumns in "S1". "S2(2)" is the number of dimensions that "X" has. 
last = 1;   

for i= 1:S2(2)      % The total number of operations to be done can be calculated by multiplying the number of elements in each dimension of "X" . This has to be done for each dimension. This number is stored in "last".  
    last = last*S1(i);
end

res = 0;

    for i = 1:last      % Calculate the sum of the squares of all the elements of the input Matrix "X".
        res = res + abs(X(i))^2;        
    end
    
    res = res^(1/2);    % "res" equals the squareroot of the sum of the sqaures of all the elements in "X". Return "res".

end