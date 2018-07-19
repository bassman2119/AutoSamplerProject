classdef gradDescent < handle
   methods
       function gradOut = grad(f, stepsize, X0)
           temp = zeros(size(X0)); 
           for i = 1:size(X0,2)
               temp(i)=(f(X0(i)+stepsize)-f(X0(i)))/stepsize;
           end
           gradOut = temp;
       end       
   end
end