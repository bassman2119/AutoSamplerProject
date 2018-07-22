classdef gradDescent < handle
   methods
       function gradOut = grad(obj,f, stepsize, X0) % static method is due to not wanting to modify an object. thus one does not have to pass an object variable to the function
           temp = zeros(size(X0)); 
           
           for i = 1:size(X0,2)
               
               temp(i)=(f(obj.elementShift(X0,i,stepsize))-f(X0))/stepsize;
               
           end %for end
           gradOut = temp;
       end %function end
   end
   methods (Static)
       function Out = elementShift(Vec,element,shift)
           Vec(element) = Vec(element)+shift;
           Out = Vec;
       end%function end
   end
end