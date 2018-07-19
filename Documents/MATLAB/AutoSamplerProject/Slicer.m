classdef Slicer < handle
    properties (Access = private)
        NumSlice;
        AudioIn;
        OutRender;
        sliceCoeff;
        sliceShift;
        Slices = {};
    end
    properties
    end
    methods
        function obj = Slicer(inSound,nSlice)
            if nSlice<= size(inSound,1)
                obj.AudioIn = inSound;
            else
                error('The number of divisions is greater than the available number of samples.')
            end
            obj.NumSlice = nSlice;                          % Set internal variables to values of passed variales
            obj.sliceCoeff = zeros(1,nSlice);
            obj.sliceShift = zeros(1,nSlice);
            obj.mkSlices();                                 % Create slices
            obj.OutRender = zeros(size(inSound));
        end
        
        function Out = mkRender(obj,B)
            for i = 1:obj.NumSlice
                
            end
            Out = obj.OutRender;
        end
        
        function mkSlices(obj)
                sliceSize = floor(size(obj.AudioIn,2)/obj.NumSlice);                                            % Length of one slice in samples
                useOffset = gt(size(obj.AudioIn,2)/obj.NumSlice,floor(size(obj.AudioIn,2)/obj.NumSlice));       % If sliceSize was rounded down due to "floor" function, useOffset = 1, else useOffset = 0.   
                for i = 1:obj.NumSlice
                    offset = floor(i/obj.NumSlice);                                                             % If i = NumSlice, offset = 1, else offset = 0   
                    obj.Slices(i).slice = obj.AudioIn((i-1)*sliceSize+1:(i*sliceSize+useOffset*offset));        % Create slice of length sliceSize. Add offset to length of slice only if Numslice does not divide into Size()
                end
        end     
    end
    
%---------------- Getter methods -----------------------------------------%    
    methods                
        function slices = getSlices(obj)
            slices = obj.Slices;            % returns "Slices" structure array
        end 
        function shift = getsliceShift(obj)
            shift = obj.sliceShift;            % Sets "sliceCoeff" value array
        end    
        function coeff = getsliceCoeff(obj)
            coeff = obj.sliceCoeff;            % Sets "sliceCoeff" value array
        end    
        function Render = getOutRender(obj)
            Render = obj.OutRender;            % Sets "sliceCoeff" value array
        end    
    end
%---------------- Setter methods -----------------------------------------%
 methods  
     function setsliceCoeff(obj,Val)
            obj.sliceCoeff = Val;            % Sets "sliceCoeff" value array
     end     
     function setsliceShift(obj,Val)
            obj.sliceShift = Val;            % Sets "sliceShift" value array
     end       
 end
    
end