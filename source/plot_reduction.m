


scrsz = get(0,'ScreenSize');



figure ('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;


subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('k');
plot(datcolor1(:,xi),datcolor1(:,yi),'.b','markersize',4)
hold on

xlabel('nm','color','k')
ylabel('nm','color','k')
title(['color1 ch0 fix'],'Fontsize',9,'FontWeight','normal','color','w')


subplot('Position',[0.535, 0.11, 0.44, 0.8])
whitebg('k')




plot(datcolor2(:,xi),datcolor2(:,yi),'.r','markersize',4)
 hold on
% xlim([min(dat2(:,xi2)),max(dat2(:,xi2))])
% ylim([min(dat2(:,yi2)),max(dat2(:,yi2))])
xlabel('nm','color','k')
ylabel('nm','color','k')
title(['color2 ch1 moving'],'Fontsize',9,'FontWeight','normal','color','w')

suptitle('Data after filtration')




figure('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.99 scrsz(4)/1.25]) ;


plot(datcolor2(:,xi),datcolor2(:,yi),'.r','markersize',16)
hold on 
plot(datcolor1(:,xi),datcolor1(:,yi),'.b','markersize',8)
legend('Color1 ch1','Color2 ch0')
title ('Data after filtration')
clear('scrsz','eppp','eppn','zz1','zz2')