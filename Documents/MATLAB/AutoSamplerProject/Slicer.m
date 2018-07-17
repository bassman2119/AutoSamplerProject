classdef Slicer < handle
    properties (Access = private)
        NumSlice;
        AudioIn;
        OutRender;
        sliceCoeff;
        sliceShift;
        Slices;
    end
    properties
    end
    methods
        function obj = Slicer(inSound,nSlice)
            if nSlice<= size(inSound,2)
                obj.AudioIn = inSound;
            else
                error('The number of divisions is greater than the available number of samples.')
            end
            obj.NumSlice = nSlice;
            obj.sliceCoeff = zeros(1,nSlice);
            obj.sliceShift = zeros(1,nSlice);
            
           % obj.mkSlices();
        end
        
        function mkSlices()
            
        end
    end

    
end