clear 
close all
clc


[pathname,dirname] = uigetfile('interpolated*.mat');
fullpath = fullfile(dirname,pathname);
load(fullpath);





plot_interpolated_displacement

stop1;
Data_Load_1;
Data_Load_2;
rama=1000;
maxXdat1=max(dat1(:,xi1))+ rama;
maxYdat1=max(dat1(:,yi1))+ rama;
maxXdat2=max(dat2(:,xi2))+ rama;
maxYdat2=max(dat2(:,yi2))+ rama;

dat2N=[];


dat2N=dat2;
zn=dat2(:,zi2);
xn=gfx(zn);
yn=gfy(zn);
dat2N(:,xi2)=dat2N(:,xi2)+xn;
dat2N(:,yi2)=dat2N(:,yi2)+yn;

  
    
    
    
    
    
    
    scrsz = get(0,'ScreenSize');
     
    
    
    figure(151)
    whitebg('k')
    set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);

    plot(dat2(:,xi2),dat2(:,yi2),'+b')
    hold on
   
 
    plot(dat2N(:,xi2),dat2N(:,yi2),'.g')
    pause(0.2)
    suptitle('Color2 after registration (blue old point, green neu point)')
   

  
    
    
po1=dat1(:,[xi1,yi1,zi1]);
po2=dat2N(:,[xi2,yi2,zi2]);
plot_gobal(po1,po2)


par.pkmatrix=dat2N;
tt=[dirname1,'registred_intepolated_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname1,'.mat'];
save(tt,'par');
clear( 'dm','pm','pmn','R','t', 'V', 'en', 'ep', 'k' ,'i','po1' ,'po2')
clear('button', 'data1', 'data2',  'ih', 'status')




