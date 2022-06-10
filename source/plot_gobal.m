

function plot_gobal(P1,P2)
scrsz = get(0,'ScreenSize');


figure ('OuterPosition', [scrsz(3)/4 scrsz(4)/10 scrsz(4)/1.0 scrsz(4)/1.25]) ;



whitebg('k');
plot3(P1(:,1),P1(:,2),P1(:,3),'.b','markersize',4)
hold on
grid on
plot3(P2(:,1),P2(:,2),P2(:,3),'.r','markersize',4)
%axis image
xlabel('nm','color','w')
ylabel('nm','color','w')
legend('color1 ch0 original','color2 ch1 translated')


title('Color1 ch0 original Color2 ch1 after registration to Color1')



figure ('OuterPosition', [scrsz(3)/4 scrsz(4)/10 scrsz(4)/1.0 scrsz(4)/1.25]) ;


%subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('k');
plot(P1(:,1),P1(:,2),'.b','markersize',4)
hold on
plot(P2(:,1),P2(:,2),'.r','markersize',4)
%axis image
xlabel('nm','color','w')
ylabel('nm','color','w')
legend('color1 ch0 original','color2 ch1 after translation')
title('Color1 ch0 original Color2 ch1 after registration to Color1')




end