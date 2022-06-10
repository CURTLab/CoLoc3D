clc
%%%%%%%%%%%%%%%%%%%%%%%% open file 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
uiwait(msgbox('SELECT ACTIVE (MOBILE) DATA: Color2','modal')); 

[pathname,dirname] = uigetfile('..\*.mat');
fullpath = fullfile(dirname,pathname);
fullpath2=fullpath;
dirname2=dirname;
pathname2=pathname;

load(fullpath);
exname=pathname;
exname = strrep(exname,'_','-');
exname2 = strrep(exname,'.mat','');
clear('fullpath', 'datacell', 'dirname', 'pathname')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_test= exist('par','var');


%%%%%%%%%%%%%%%%%%%%%%data and index preparation%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if data_test == 1
 colhead2=par.pkdesc.desc';
 %colhead2=colhead;
 dat2=par.pkmatrix;
  [xi2,yi2,zi2,ini2,sxi2,syi2,szi2,fri2,lasti2]=data_extraction_index(colhead2);
 %clear('par');
else
 clear
 a_info_wrong_data;
 stop_wrong_data;
end


%%%%%%%%%%%%%%%%%%% NaN value elimination %%%%%%%%%%%%%%%%%%%% 


%%%%%%%%%%% NaN elimination

ww=[];
 for i=1:lasti2
    snan=isnan(dat2(:,i));
    snani=find(snan==1);
    ww=union(ww,snani);
end
dat2(ww,:)=[];
N2=size(dat2,1);

sfrM2=max(dat2(:,fri2));
w=hist(dat2(:,fri2),sfrM2);
wm=round(mean(w));

%%%%%%%%%%%%%%%%%%%% dat statistic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
status=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_original_data(dat2(:,xi2),dat2(:,yi2),dat2(:,zi2),exname2,w,sfrM2);
%%%%%%%%%%%%%%%%%%%%%%%%%end load %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear('ww','snan','snani','toleranz','data_test','i','wm','exname')
clear('w','sfrM2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



