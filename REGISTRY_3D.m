% MIT License
% 
% Copyright (c) 2022 Jaroslaw Jacak, 
% Medical Engineering Dept. Upper Austria University od Applied Sciences, Linz, Austria
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

addpath('source')

clear 
close all
clc

uiwait(msgbox('SELECT DISPLACEMENT FIELD','modal')); 

[pathname,dirname] = uigetfile('calibration*.mat');
fullpath = fullfile(dirname,pathname);
load(fullpath);

plot_displacement(grid_size,xg1,yg1,sizeMcolor1(1),sizeMcolor1(2),TO);
stop1;
Data_Load_1;
Data_Load_2;
rama=100;
maxXdat1=max(dat1(:,xi1))+ rama; %+ rama;
maxYdat1=max(dat1(:,yi1))+ rama;
maxXdat2=max(dat2(:,xi2))+ rama;
maxYdat2=max(dat2(:,yi2))+ rama;

xgr=[];
ygr=[];
for ih=1:grid_size
    xgr(ih+1)=round(((1/grid_size)*ih),2)*maxXdat2;
    ygr(ih+1)=round(((1/grid_size)*ih),2)*maxYdat2;
end

dat2N=[];


for  i=1:grid_size
ep=find(dat2(:,xi2)>xgr(i) & dat2(:,xi2)<=xgr(i+1) );
dat2(ep,lasti2+1)=i;
end
segxi2=lasti2+1;
for  i=1:grid_size
ep=find(dat2(:,yi2)>ygr(i) & dat2(:,yi2)<=ygr(i+1) );
dat2(ep,lasti2+2)=i;
end
segyi2=lasti2+2;

for i = 1:grid_size
 for k= 1:grid_size

    ep=find(dat2(:,segxi2)==i & dat2(:,segyi2)==k);
    
    if isempty(ep)==0
    dm=dat2(ep,:);
    pm=dm(:,[xi2,yi2,zi2]);
    en=find(TO(15,:)==i & TO(16,:)==k);
    V=TO(:,en);
    [R,t]=vectorTF2RTn(V);
    pmn =zaz_correction_mobile_RT(R,t,pm);
    
    dm(:,[xi2,yi2,zi2])= pmn;
    dat2N=[dat2N',dm']';
  
    
    scrsz = get(0,'ScreenSize');
    figure(151)
    set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);

    plot(dat2(:,xi2),dat2(:,yi2),'.b')
    hold on
    plot_grid(grid_size,xgr,ygr)
    plot(dm(:,xi2),dm(:,yi2),'or','markersize',2,'markerfacecolor','r')
    plot(dat2N(:,xi2),dat2N(:,yi2),'.g')
    pause(0.1)
    title('Color2 after translacji (blue old point, green neu point)')
    end
 end
end


po1=dat1(:,[xi1,yi1,zi1]);
po2=dat2N(:,[xi2,yi2,zi2]);
plot_gobal(po1,po2)

colhead2(lasti2+1)={'segxi'};
colhead2(lasti2+2)={'segyi'};
par.pkmatrix=dat2N;
par.pkdesc.desc=colhead2';
%tt=[dirname2,'registred_',exname2,'.mat'];

tt=[dirname2,'registred_grid_',num2str(day(datetime)),'_',num2str(month(datetime)),'_GR_',num2str(grid_size),'_',exname2,'.mat'];
%save(tt,'colhead2','dat2N','exname2','grid_size','segxi2','segyi2','xg2', 'xgr', 'yg2','par');
save(tt,'par');

clear( 'dm','pm','pmn','R','t', 'V', 'en', 'ep', 'k' ,'i','po1' ,'po2')
clear('button', 'data1', 'data2',  'ih', 'status')
