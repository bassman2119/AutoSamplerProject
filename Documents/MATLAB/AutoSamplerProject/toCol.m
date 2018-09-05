function out = toCol(U)
if size(U,2)>size(U,1)  % If the number of collumns in U is greater than the number of rowss (U is a row vector), transpose "U" and return out to the calling function. 
    out = U.' ;
    return
end
out = U;                % If "U" is already a collumn vector leave "U" unchanged and return.

end