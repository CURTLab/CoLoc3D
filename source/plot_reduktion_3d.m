if exist('dat2','var')==1

clc
scrsz = get(0,'ScreenSize');
zz1=dat1(:,zi1);
zz2=dat2(:,zi2);


figure ('OuterPosition', [scrsz(3)/4.7 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;


subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('k');
eppn=find(zz1(:,1)<0);
eppp=find(zz1(:,1)>=0);


plot3(dat1(eppn,xi1),dat1(eppn,yi1),dat1(eppn,zi1),'.b','markersize',1)
hold on
plot3(dat1(eppp,xi1),dat1(eppp,yi1),dat1(eppp,zi1),'.y','markersize',1)

xlim([min(dat1(:,xi1)),max(dat1(:,xi1))])
ylim([min(dat1(:,yi1)),max(dat1(:,yi1))])
xlabel('nm','color','k')
ylabel('nm','color','k')
axis image 
title(['{\it S1} ',exname1,' (',num2str(N1),' points)'],'Fontsize',9,'FontWeight','normal','color','y')


subplot('Position',[0.535, 0.11, 0.44, 0.8])
whitebg('k')
eppn=find(zz2(:,1)<0);
eppp=find(zz2(:,1)>=0);
whitebg('k')
 plot3(dat2(eppn,xi2),dat2(eppn,yi2),dat2(eppn,zi2),'.b','markersize',1)
 hold on
 plot3(dat2(eppp,xi2),dat2(eppp,yi2),dat2(eppp,zi2),'.y','markersize',1)

 xlim([min(dat2(:,xi2)),max(dat2(:,xi2))])
 ylim([min(dat2(:,yi2)),max(dat2(:,yi2))])
xlabel('nm','color','k')
ylabel('nm','color','k')
axis image 
title(['{\it S2} ',exname2,' (',num2str(N2),' points)'],'Fontsize',9,'FontWeight','normal','color','y')
suptitle(['Data taken to comparison. X-Y view. Yellow-posiv z, Blue-negativ z. Sample1= ',...
    num2str(N1),' Sample2= ',num2str(N2),' points'])

else
    clc
    disp(' ');
    disp('Sample 2 do not exists. Please load data of sample 2');
    a_info_load;
end
clear('scrsz','eppp','eppn','zz1','zz2')