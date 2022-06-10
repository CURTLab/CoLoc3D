clc
close all
whitebg('w')
close
%%%%%%%%%%%%%%%%%%%%%%%%% open file YAML Channel-0   %%%%%%%%%%%%%%%%%%%%%%%%%%%
uiwait(msgbox('SELECT YAML CALIBRATION DATA CANNEL 0','modal'));
[pathname,dirname] = uigetfile('..\*.yaml');
fullpath = fullfile(dirname,pathname);
testYAML;
focus_ch0=cali.Focus;

%%%%%%%%%%%%%%%%%%%%%%%%% open file YAML Channel-1  %%%%%%%%%%%%%%%%%%%%%%%%%%%

uiwait(msgbox('SELECT YAML CALIBRATION DATA CANNEL 1','modal'));
[pathname,dirname] = uigetfile('..\*.yaml');
fullpath = fullfile(dirname,pathname);
testYAML;
focus_ch1=cali.Focus;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear('cali','fy','ret','z','filePath')


