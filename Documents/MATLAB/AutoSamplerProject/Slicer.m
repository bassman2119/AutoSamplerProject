classdef Slicer < handle
    properties (Access = private)
        NumSlice;                               % Integer, number of slices created from "AudioIn".
        AudioIn;                                % Audio signal that will be chopped into slices (or samples in music production terms). (AudioIn is a collumn vector).
        OutRender;                              % Audio signal generated using the slices. 
        sliceCoeff;                             % Parameters used to generate the OutRender signal from the slices.
        sliceShift;                             % Parameters used to generate the OutRender signal from the slices.
        Slices = {};                            % Structure array containing the slices extracted from AudioIn.
    end
    
    methods
        function obj = Slicer(inSound,nSlice)   % Object constructor function. 
            if round(nSlice)<= size(inSound,2)  % Only create object if there are enough samples in AudioIn
                obj.AudioIn = inSound;
            else
                error('The number of divisions is greater than the available number of samples.')
            end
            obj.NumSlice = round(nSlice);                                                       % Set internal variables to values of passed variales. Round non-integer values.
            obj.sliceCoeff = ones(obj.NumSlice,1);                                              % coefficiants can be real numbers. "obj.sliceCoeff" is a collumn vector of length "NumSlice".
            temp = toCol(round(linspace(1,size(toCol(inSound),1)+1,obj.NumSlice+1)));           % shift values must be whole positive numbers because they give a number of samples to shift right starting from the first sample. "obj.sliceShift" is a collumn vector of length "NumSlice".
            obj.sliceShift = temp(1:obj.NumSlice);
            obj.mkSlices;                                                                       % Create slices.
            obj.OutRender = zeros(size(toCol(inSound)));                                        % Initialize "outRender".
        end
        
        function Out = mkRender(obj,B)
            offset = min(B(1:obj.NumSlice));                                                % "offset" contains the most negative element of the vector "B(1:obj.NumSlice)"
            a = (B(1:obj.NumSlice)-offset+1);                                               % a contains the shift values for each slice. Each shift value has been tared to "offset". 
            b = B((obj.NumSlice+1):(2*obj.NumSlice));                                       % b contains the scaling factors for each slice.
            c = obj.Slices;                                                                 % c is a struc array containing the slices.
            d = zeros(size(obj.OutRender,1)+abs(offset),size(obj.OutRender,2));
            for k = 1:obj.NumSlice  
                d(a(k):(a(k)+size(c(k).slice,1)-1)) =  b(k)*c(k).slice;                     % Place sequence of values in "c(i).slice" in the "OutRender" vector with the first element of "c(i).slice" being written into "OutRender(a(i))". Use a scaling factor of 

            end
            
            if offset == 0
                obj.OutRender = d(1:(size(obj.AudioIn,2)));                                 % Cut off all elements whos index goes past the size of "OutRender" at initialisation.
                Out = obj.OutRender;                                                        % Return "OutRender".
                return 
            end
            obj.OutRender = d((abs(offset)):(size(obj.AudioIn,2)+abs(offset)-1));       % Cut off all elements whos index goes past the size of "OutRender" at initialisation.
            Out = obj.OutRender;                                                        % Return "OutRender".
            
            
        end
        
        function mkSlices(obj)
                sliceSize = floor(size(obj.AudioIn,2)/obj.NumSlice);                                                    % Length of one slice in samples
                useOffset = gt(size(obj.AudioIn,2)/obj.NumSlice,floor(size(obj.AudioIn,2)/obj.NumSlice));               % If sliceSize was rounded down due to "floor" function, useOffset = 1, else useOffset = 0.   
                for i = 1:obj.NumSlice
                    offset = floor(i/obj.NumSlice);                                                                     % If i = NumSlice, offset = 1, else offset = 0   
                    obj.Slices(i).slice = toCol(obj.AudioIn((i-1)*sliceSize+1:(i*sliceSize+useOffset*offset)));         % Create slice of length sliceSize. Add offset to length of slice only if Numslice does not divide into Size()
                end
        end     
    end
    
%---------------- Getter methods -----------------------------------------%    
    methods                
        function slices = getSlices(obj)
            slices = obj.Slices;                % Returns "Slices" structure array,
        end 
        function shift = getsliceShift(obj)
            shift = obj.sliceShift;             % Returns "sliceCoeff" value array.
        end    
        function coeff = getsliceCoeff(obj)
            coeff = obj.sliceCoeff;             % Returns "sliceCoeff" value array.
        end    
        function Render = getOutRender(obj)
            Render = obj.OutRender;             % Returns "sliceCoeff" value array.
        end    
        function Render = getNumSlice(obj)
            Render = obj.NumSlice;             % Returns "sliceCoeff" value array.
        end    
    end
%---------------- Setter methods -----------------------------------------%
 methods  
     function setsliceCoeff(obj,Val)
            obj.sliceCoeff = Val;               % Sets "sliceCoeff" value array.
     end     
     function setsliceShift(obj,Val)
            obj.sliceShift = Val;               % Sets "sliceShift" value array.
     end       
 end
    
end