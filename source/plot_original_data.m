function plot_original_data(x,y,z,exname,w,sfrM)

scrsz = get(0,'ScreenSize');
figure ('OuterPosition', [scrsz(3)/10 scrsz(4)/30 scrsz(4)/0.80 scrsz(4)/1.1]) ;

whitebg('k')
%subplot(2,2,1)
subplot('Position',[0.05, 0.35, 0.45, 0.6])

eppn=find(z(:,1)<0);
plot3(x(eppn),y(eppn),z(eppn),'.b','Markersize',1)
hold on
plotbox3(x(:,1),y(:,1),[0,0]',0)
hold on
eppp=find(z(:,1)>=0);
plot3(x(eppp,1),y(eppp,1),z(eppp,1),'.y','Markersize',1)

whitebg('k')
%axis image
hold on
plotbox3(x(:,1),y(:,1),[0,0]',0)
title (' Original data: {\it yellow - positiv Z, blue - negativ Z}');

%subplot(2,2,2)
subplot('Position',[0.5, 0.35, 0.55, 0.6])
plot(x(eppn,1),y(eppn,1),'.b','Markersize',1)
hold on
plot(x(eppp,1),y(eppp,1),'.y','Markersize',1)
axis image
title ([' Number of points = ',num2str(numel(x))]);


wm=round(mean(w));
%subplot(2,2,3)
subplot('Position',[0.05, 0.07, 0.92, 0.2])
bar(w,0.3,'g','EdgeColor','g')
hold on
line([0,sfrM],[wm,wm],'color','r','linewidth',2)
xlabel('Frame number')
ylabel ('Number of points')
legend('number of points','average point-number')
title(['{\it Data statistic: Number of points per frame.} Frames number = ',num2str(sfrM),'. Average per frame = ',...
num2str(wm),' points'])


suptitle(['\bf Data: ',exname]);
end

