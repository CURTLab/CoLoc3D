

[pathname,dirname] = uigetfile('..\*.SPE');
fullpath = fullfile(dirname,pathname);
exname=pathname;
clc
disp(pathname)
disp('SPE file is loading')
tic
[data] = loadSPE4(fullpath);