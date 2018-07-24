classdef gradDescent < handle
   methods
       function gradOut = grad(obj,f, stepsize, X0)                         % Function numerically computes the gradient of "f" with a stepsize of "stepsize".
           temp = zeros(size(X0));                                          % Initialise temporary variable.
           for i = 1:size(X0,2)
               temp(i)=(f(obj.elementShift(X0,i,stepsize))-f(X0))/stepsize; % Calculate the partial derivative of "f" with respect to its i'th variable using the difference quotient and "stepsize". Save the result in "temp".
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