clc
close all
%clear
%%%%%%%%%%%%%%%%%%%%%%%%% open file %%%%%%%%%%%%%%%%%%%%%%%%%%%
uiwait(msgbox('SELECT PASSIVE (FIX) DATA: Color1','modal')); 


[pathname,dirname] = uigetfile('..\*.mat');
fullpath = fullfile(dirname,pathname);
fullpath1=fullpath;
dirname1=dirname;
pathname1=pathname;

load(fullpath);
exname=pathname;
exname = strrep(exname,'_','-');
exname1 = strrep(exname,'.mat','');


clear('fullpath','datacell','dirname',  'pathname')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_test= exist('par','var');


%%%%%%%%%%%%%%%%%%%%%% data and index preparation %%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if data_test == 1
 colhead1=par.pkdesc.desc';
 %colhead1=colhead;
 dat1=par.pkmatrix;
 [xi1,yi1,zi1,ini1,sxi1,syi1,szi1,fri1,lasti1]=data_extraction_index(colhead1);
 clear('par');
else
 clear
 a_info_wrong_data;
 stop_wrong_data;
end


%%%%%%%%%%%%%%%%%%% NaN value elimination %%%%%%%%%%%%%%%%%%%% 


%%%%%%%%%%% NaN elimination

ww=[];
 for i=1:lasti1
    snan=isnan(dat1(:,i));
    snani=find(snan==1);
    ww=union(ww,snani);
end
dat1(ww,:)=[];

N1=size(dat1,1);


sfrM1=max(dat1(:,fri1));
w=hist(dat1(:,fri1),sfrM1);
wm=round(mean(w));
status=0;


%%%%%%%%%%%%%%%%%%%% dat statistic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_original_data(dat1(:,xi1),dat1(:,yi1),dat1(:,zi1),exname1,w,sfrM1);
%%%%%%%%%%%%%%%%%%%%%%%%%end load %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear('ww','snan','snani','toleranz','data_test','i','wm','exname')
clear('w','sfrM1')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



