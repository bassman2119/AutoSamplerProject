function out = toRow(U)
if size(U,1)>size(U,2)  % If the number of rows in U is greater than the number of collumns (U is a collumn vector), transpose "U" and return out to the calling function. 
    out = U.' 
    return
end
out = U;                % If "U" is already a row vector leave "U" unchanged and return.

end