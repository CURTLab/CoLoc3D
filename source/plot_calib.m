clc
scrsz = get(0,'ScreenSize');


figure ('OuterPosition', [scrsz(3)/4.7 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;

subplot('Position',[0.04, 0.11, 0.45, 0.8])
whitebg('w');
whitebg('w')
plot3(data1(:,xi),data1(:,yi),data1(:,zi),'.b','markersize',6)
hold on 
grid on

plot3(data2(:,xi),data2(:,yi),data2(:,zi),'og','markersize',4)
title('Ch 0 (blue) and Ch 1 (green) before calibration')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot('Position',[0.535, 0.11, 0.44, 0.8])
whitebg('k')
plot3(data1(:,xi),data1(:,yi),data1(:,zi),'.b','markersize',6)
hold on 
grid on
plot3(MPO(:,1),MPO(:,2),MPO(:,3),'og','markersize',4)
zlim([-1000,1000])
title('Ch 0 (blue) and Ch 1 (green) after calibration')
suptitle('Calibration')