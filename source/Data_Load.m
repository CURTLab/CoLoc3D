clc
clear
close all

%%%%%%%%%%%%%%%%%%%%%%%%% open file %%%%%%%%%%%%%%%%%%%%%%%%%%%
 uiwait(msgbox('SELECT CALIBRATION DATA (in Matlab Format)','modal'));
[pathname,dirname] = uigetfile('..\*.mat');
fullpath = fullfile(dirname,pathname);
load(fullpath);
exname=pathname;
clear('fullpath', 'datacell',  'pathname')
exname = strrep(exname,'_','-');
exname = strrep(exname,'.mat','');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_test= exist('par','var');


%%%%%%%%%%%%%%%%%%%%%%data and index preparation%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if data_test == 1
 colhead=par.pkdesc.desc';
 dat=par.pkmatrix;
 pix=par.pixelSize_nm;
 [xi,yi,zi,ini,sxi,syi,szi,fri,lasti]=data_extraction_index(colhead);
 clear('par');
else
 dat=data;
 [xi,yi,zi,ini,sxi,syi,szi,fri,lasti]=data_extraction_index(colhead_a);
 clear('data');
end

N=numel(dat(:,xi));
%%%%%%%%%%%%%%%%%%% NaN value elimination %%%%%%%%%%%%%%%%%%%% 


%%%%%%%%%%% NaN elimination

ww=[];
 for i=1:lasti
    snan=isnan(dat(:,i));
    snani=find(snan==1);
    ww=union(ww,snani);
end
dat(ww,:)=[];

sfrM=max(dat(:,fri));
sfrm=min(dat(:,fri));

w=hist(dat(:,fri),sfrM);
wm=round(mean(w));

toleranz=mean(dat(:,[sxi,sxi,szi]));
max_limit_drift=1.0*sqrt(toleranz(1)^2+toleranz(2)^2+toleranz(3)^2) ;

clear('ww','snan','snani','toleranz','data_test','i')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_original_data(dat(:,xi),dat(:,yi),dat(:,zi),exname,w,sfrM);
%%%%%%%%%%%%%%%%%%%%%%%%%end load %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%% dat z test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[z_empty, z_step]=Z_axis_test(dat,zi,fri);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear('w','wm')








