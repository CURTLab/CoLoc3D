clc
close all
clear
%%%%%%%%%%%%%%%%%%%%%%%%% open file %%%%%%%%%%%%%%%%%%%%%%%%%%%

[pathname,dirname] = uigetfile('..\*.x*');
fullpath = fullfile(dirname,pathname);
try
par= importdata(fullpath);  

catch
    clear
    clc
    START_CALIBRATION;
end


exname=pathname;
exnameo = strrep(exname,'.','_');
exname = strrep(exnameo,'_','-');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% check data and index establishing %%%%%%%%%%%%%%%%%%%%%%%%%%

if exist('par','var') == 1
 colhead=par.colheaders;
 dat=par.data;

 [xi,yi,zi,ini,sxi,syi,szi,fri,lasti,colhead,dat]=E_data_extraction_index(colhead,dat);

else
    clc
    E_wrong_dat_info;
    clear
    START_CALIBRATION;
end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%%%%%%%%%%%%%%%%%%%%%%%%% transformation %%%%%%%%%%%%%%%%%%%%%%%%%
par.pkmatrix=dat;
par.data=[];
par.pkdesc.desc=colhead';
par.pkdesc.units={'nanometer'};
par.colheaders=colhead;
par.textdata=[];
par.pixelSize_nm=1.666670000000000e+02;
tekst=[dirname,exnameo];
save(tekst,'par')
msgbox(['Excel data has been successfully transformed into Matab format and saved in their directory under the name ',...
exnameo,'.mat. Use Load New Data button to analyze them.'])

clear('fullpath','tekst','dirname','pathname','exnameo')
clear
