
scrsz = get(0,'ScreenSize');


figure ('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;


%subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('k');
grid on
plot3(datcolor1g(:,xi),datcolor1g(:,yi),datcolor1g(:,zi),'.b','markersize',6)
hold on
plot3(datcolor1g(:,cenxi),datcolor1g(:,cenyi),datcolor1g(:,cenzi),'om','markersize',5)%'markerfacecolor','b'
hold on
plot3(datcolor2g(:,xi),datcolor2g(:,yi),datcolor2g(:,zi),'.r','markersize',6)
plot3(datcolor2g(:,cenxi),datcolor2g(:,cenyi),datcolor2g(:,cenzi),'ow','markersize',5)%'markerfacecolor','r'
grid on
xlabel('nm','color','w')
ylabel('nm','color','w')
view(2)
legend('color1 ch0','centroid color1','color2 ch1','centroid color2')
title('Data after filtration and clustering (3D)')