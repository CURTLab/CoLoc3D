
scrsz = get(0,'ScreenSize');


figure ('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;


%subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('k');
grid on
plot3(datcolor1g(:,xi),datcolor1g(:,yi),datcolor1g(:,zi),'.b','markersize',5)
hold on
plot3(datcolor1ff(:,14),datcolor1ff(:,15),datcolor1ff(:,16),'sm','markersize',2)%'markerfacecolor','b'
hold on
plot3(datcolor2ff(:,xi),datcolor2ff(:,yi),datcolor2ff(:,zi),'.r','markersize',10)
plot3(datcolor2ff(:,14),datcolor2ff(:,15),datcolor2ff(:,16),'ow','markersize',3)%'markerfacecolor','r'
grid on
xlabel('nm','color','w')
ylabel('nm','color','w')
view(2)
legend('color1 ch0','centroid color1','color2 ch1','centroid color2')
title('Data after strong filtration ')