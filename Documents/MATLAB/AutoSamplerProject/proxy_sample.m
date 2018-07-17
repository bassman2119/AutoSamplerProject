clear
clc

%-------------------Import audio------------------------------------------%
filename = 'Beneath With Me (Full Unofficial Version) HD.mp3'
[Y1,Fs]=audioread(filename);
[Y2,Fs]=audioread(filename);
%-------------------Slice-------------------------------------------------%
Nslice = 30;
S = Slicer(Y2,Nslice);

%-------------------aproximate using slices-------------------------------%
ErrorRatio = differenceGetter(Y1,S.Out);
while Error > 100
    S.Iterate_Params;
    ErrorRatio = L2_vecNorm(abs(Y1-S.Out));
end
%-------------------export audio------------------------------------------%

Outfile = 'magled_('+filename + ')';
audiowrite(Outfile,S.Out,Fs)

