
function z_plot_test(POS1,POS2,titel)
scrsz = get(0,'ScreenSize');
figure ('OuterPosition', [scrsz(3)/4.7 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;
whitebg('k')
plot3(POS1(:,1),POS1(:,2),POS1(:,3),'.b','markersize',4)
hold on 
plot3(POS2(:,1),POS2(:,2),POS2(:,3),'or','markersize',4,'linewidth',1.5)
plot3(POS1(:,1),POS1(:,2),POS1(:,3),'.b','markersize',10)
grid on
view(2)
legend('color1 ch0','color2 ch1')
title (titel)
grid on
end