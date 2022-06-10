clc
close all
clear
%%%%%%%%%%%%%%%%%%%%%%%%% open file %%%%%%%%%%%%%%%%%%%%%%%%%%%
try
[pathname,dirname] = uigetfile('..\*.cs*');
fullpath = fullfile(dirname,pathname);
par= importdata(fullpath);  
catch
end


exname=pathname;
exnameo = strrep(exname,'.','_');
%exname = strrep(exnameo,'_','-');
exname=exnameo;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% check data and index establishing %%%%%%%%%%%%%%%%%%%%%%%%%%
try
if exist('par','var') == 1
 colhead=par.colheaders;
 dat=par.data;
end
catch
    clc
end


try
[xi,yi,zi,ini,sxi,syi,szi,fri,lasti,dat,colhead]=E_data_extraction_index(colhead,dat);
catch
    clc
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








%%%%%%%%%%%%%%%%%%%%%%%%% transformation %%%%%%%%%%%%%%%%%%%%%%%%%
par.pkmatrix=dat;
par.data=[];
par.pkdesc.desc=colhead';
par.pkdesc.units={'nanometer'};
par.colheaders=[];
par.textdata=[];

tekst=[dirname,exnameo];
save(tekst,'par')
msgbox(['Excel data has been successfully transformed into Matab format and saved in their directory under the name ',...
exnameo,'.mat. Use Load New Data button to analyze them.'])

%clear('fullpath','tekst','dirname','pathname','exnameo')
%clear

