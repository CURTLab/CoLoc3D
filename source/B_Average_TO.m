%close all
clc

%uiwait(msgbox('SELECT DISPLACEMENT FIELD','modal')); 

%[pathname,dirname] = uigetfile('calibration*.mat');
%fullpath = fullfile(dirname,pathname);
%load(fullpath);





%plot_displacement(grid_size,xg1,yg1,sizeMcolor1(1),sizeMcolor1(2),TO);
%stop1;
%Data_Load_1;
%Data_Load_2;
dat1=data1;
dat2=data2;
%rama=100;
%maxXdat1=max(dat1(:,xi1))+ rama; %+ rama;
%maxYdat1=max(dat1(:,yi1))+ rama;
%maxXdat2=max(dat2(:,xi2))+ rama;
%maxYdat2=max(dat2(:,yi2))+ rama;


%xgr=[];
%ygr=[];
%for ih=1:grid_size
    %xgr(ih+1)=round(((1/grid_size)*ih),2)*maxXdat2;
    %ygr(ih+1)=round(((1/grid_size)*ih),2)*maxYdat2;
%end

DATCR=[];


%for  i=1:grid_size
%ep=find(dat2(:,xi2)>xgr(i) & dat2(:,xi2)<=xgr(i+1) );
%dat2(ep,lasti2+1)=i;
%end
%segxi2=lasti2+1;
%for  i=1:grid_size
%ep=find(dat2(:,yi2)>ygr(i) & dat2(:,yi2)<=ygr(i+1) );
%dat2(ep,lasti2+2)=i;
%end
%segyi2=lasti2+2;

for i = 1:grid_size
 for k= 1:grid_size

    ep=find(dat2(:,segxi)==i & dat2(:,segyi)==k);
    
    if isempty(ep)==0
    dm=dat2(ep,:);
    pm=dm(:,[xi,yi,zi]);
    en=find(TOO(15,:)==i & TOO(16,:)==k);
    V=TOO(:,en);
    [R,t]=vectorTF2RTn(V);
    pmn =zaz_correction_mobile_RT(R,t,pm);
    
    dm(:,[xi,yi,zi])= pmn;
    DATCR=[DATCR',dm']';
  
    
    scrsz = get(0,'ScreenSize');
    figure(151)
    set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);

    plot(dat2(:,xi),dat2(:,yi),'.b')
    hold on
    %plot_grid(grid_size,xgr,ygr)
    plot(dm(:,xi),dm(:,yi),'or','markersize',2,'markerfacecolor','r')
    plot(DATCR(:,xi),DATCR(:,yi),'.g')
    pause(0.1)
    title('Color2 after translacji 2D view (blue old point, green neu point)')
   
    


    end
 end
end

 close all
po1=dat1(:,[xi,yi,zi]);
po2=DATCR(:,[xi,yi,zi]);





%plot_gobal(po1,po2)

%colhead2(lasti2+1)={'segxi'};
%colhead2(lasti2+2)={'segyi'};
%par.pkmatrix=dat2N;
%par.pkdesc.desc=colhead2';
%tt=[dirname2,'registred_',exname2,'.mat'];

%tt=[dirname2,'registred_grid_',num2str(day(datetime)),'_',num2str(month(datetime)),'_GR_',num2str(grid_size),'_',exname2,'.mat'];
%save(tt,'colhead2','dat2N','exname2','grid_size','segxi2','segyi2','xg2', 'xgr', 'yg2','par');
%save(tt,'par');



%clear( 'dm','pm','pmn','R','t', 'V', 'en', 'ep', 'k' ,'i','po1' ,'po2')
%clear('button', 'data1', 'data2',  'ih', 'status')

av_mse=mse_voll(po2,po1)

