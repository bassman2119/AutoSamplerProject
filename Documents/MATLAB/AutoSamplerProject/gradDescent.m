classdef gradDescent < handle
   methods
       function gradOut = grad(obj,f, stepsize, X0)                         % Function numerically computes the gradient of "f" using the forward difference approximation with a stepsize of "stepsize".
           temp = zeros(size(X0));                                          % Initialise temporary variable.
           for j = 1:size(X0,1)
               temp(j)=(f(obj.elementShift(X0,j,stepsize))-f(X0))/stepsize; % Calculate the partial derivative of the function "f" with respect to its i'th variable using the forward difference quotient and "stepsize". Save the result in "temp".
           end 
           gradOut = temp;                                                  % Return the calculated gradient.
       end  
   end 
   
   methods (Static)
       function Out = elementShift(Vec,i,shift)                             % Function adds the amount "shift" to the i'th element in "Vec".
           Vec(i) = Vec(i)+shift;
           Out = Vec;
       end 
   end 
end 