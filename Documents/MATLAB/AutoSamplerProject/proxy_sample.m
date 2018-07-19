clear
clc

%-------------------Import audio------------------------------------------%
filename = 'Beneath With Me (Full Unofficial Version) HD.mp3';
[Y1,Fs]=audioread(filename);
[Y2,Fs]=audioread(filename);
Original = Y1(:,1);
Sample = Y2(:,1);
%-------------------Slice-------------------------------------------------%
Nslice = 30;
S = Slicer(Y2,Nslice);
G = gradDescent;
Render= zeros(size(Sample));

%-------------------aproximate using slices-------------------------------%
step = 0.1;
for number = 1:5
   
    
    S.setsliceShift(S.getsliceShift-step*gradient(1:Nslice));
    S.setsliceCoeff(S.getsliceCoeff-step*gradient((Nslice+1):(2*Nslice)));
end
%-------------------export audio------------------------------------------%

Outfile = 'mangled_('+filename + ')';
audiowrite(Outfile,S.Out,Fs)





