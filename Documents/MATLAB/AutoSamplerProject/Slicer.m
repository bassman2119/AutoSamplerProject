classdef Slicer < handle
    properties (Access = private)
        NumSlice;                               % Integer, number of slices created from "AudioIn".
        AudioIn;                                % Audio signal that will be chopped into slices (or samples in music production terms). (AudioIn is a collumn vector).
        OutRender;                              % Audio signal generated using the slices. 
        sliceCoeff;                             % Parameters used to generate the OutRender signal from the slices.
        Slices = {};                            % Structure array containing the slices extracted from AudioIn.
        SMat;                                   % Matrix used in the creation of the renders. SMat contains the slices arranged in a vector-block dieagonal form.
    end
    
    methods
        function obj = Slicer(inSound,nSlice,scInit)                                                % Object constructor function. 
            if round(nSlice)<= size(inSound,2)                                                      % Only create object if there are enough samples in AudioIn
                obj.AudioIn = inSound;
            else
                error('The number of divisions is greater than the available number of samples.')
            end
            
            if round(nSlice) == nslice                                                              % Only create object if nslice is a whole number
               obj.NumSlice = nSlice;                                                               % Set internal variables to values of passed variales. Round non-integer values.
            else
                error('"nslice" must be a whole number.')
            end
            
            if max(size(scInit)) == nslice                                                          % Only create object if there are enough initial coefficieants to generate sound.
                obj.sliceCoeff = toCol(scInit);                                                     % coefficiants can be real numbers. "obj.sliceCoeff" is a collumn vector of length "NumSlice".
            else
                error('"scInit" must be a vector with length "nslice".')
            end
            obj.mkSlices;                                                                           % Create slices.
            obj.OutRender = zeros(size(toCol(inSound)));                                            % Initialize "outRender".
        end
        
        function Out = mkRender(obj,B)
            switch nargin
                case 1
                    obj.OutRender = obj.SMat*obj.sliceCoeff;
                case 2 
                    obj.OutRender = obj.SMat*B;    
            end
            Out = obj.OutRender;
        end
        
        function mkSlices(obj) 
            shift = floor(max(size(obj.AudioIn))/obj.NumSlice);
            obj.SMat = zeros(max(size(obj.AudioIn)),obj.NumSlice);
            for i = 1:obj.NumSlice-1
                c = obj.AudioIn(((i-1)*shift+1):i*shift);
                obj.SMat(((i-1)*shift+1):i*shift,i) = c;
                obj.Slices(i).slice = c;                
            end
            obj.SMat(((obj.NumSlice-1)*shift+1):end,obj.NumSlice) = obj.AudioIn(((obj.NumSlice-1)*shift+1):end);
            obj.Slices(obj.NumSlice).slice = obj.AudioIn(((obj.NumSlice-1)*shift+1):end);
        end
    end
    
%---------------- Getter methods -----------------------------------------%    
    methods                
        function slices = getSlices(obj)
            slices = obj.Slices;                % Returns "Slices" structure array.
        end 
        function Mat = getSMat(obj)
            Mat = obj.SMat;                     % Returns "SMat" matrix.
        end 
        function coeff = getsliceCoeff(obj)
            coeff = obj.sliceCoeff;             % Returns "sliceCoeff" vector.
        end    
        function Render = getOutRender(obj)
            Render = obj.OutRender;             % Returns "OutRender" vector.
        end    
        function numslice = getNumSlice(obj)
            numslice = obj.NumSlice;            % Returns "NumSlice" scalar.
        end    
    end
%---------------- Setter methods -----------------------------------------%
    methods  
        function setsliceCoeff(obj,Val)
               obj.sliceCoeff = Val;            % Sets "sliceCoeff" value array.
        end     
    end
    
end