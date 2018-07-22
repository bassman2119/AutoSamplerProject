clear
clc

%-------------------Import audio------------------------------------------%
filename = 'Beneath With Me (Full Unofficial Version) HD.mp3';
[Y1,Fs]=audioread(filename);
[Y2,Fs]=audioread(filename);

Original = Y1(20000:40000,1);
Sample = Y2(20000:40000,1);
%-------------------Slice-------------------------------------------------%
Nslice = 10;
S = Slicer(Sample,Nslice);
G = gradDescent;
getError = @(A) L2_vecNorm(S.mkRender(A)-Original);         %function to be minimised. getError creates the Render of the Slice Object using the current shift an coeffs. then uses the L2 Vector norm on the difference between the render and the original signal.
%-------------------aproximate using slices-------------------------------%
step = 500;    %step is only allowed to be a whole number
for number = 1:20
    gradient = ceil(abs(G.grad(getError,ceil(abs(step)),[abs(S.getsliceShift),S.getsliceCoeff])));     % ciel(abs(step)) ensures that the value passed to G.grad is positive and a whole number 
    plot(S.getOutRender)
    S.setsliceShift(S.getsliceShift-step*gradient(1:Nslice));               %descend gradient
    S.setsliceCoeff(S.getsliceCoeff-step*gradient((Nslice+1):(2*Nslice)));
end
%-------------------export audio------------------------------------------%

%Outfile = 'mangledFile';
%audiowrite(Outfile,S.OutRender,Fs)




