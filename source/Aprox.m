clc
zz=TO(9,:);
xx=TO(5,:);
yy=TO(6,:);
z=-1000:1:1000;
[gfx,gox]=fit(zz',xx','smoothingspline','SmoothingParam',0.001);%'fourier4') %
%;   
[gfy,goy]=fit(zz',yy','smoothingspline','SmoothingParam',0.001);%;'fourier4')%
%
 
 D=[];
 D(:,1)=datcolor2(:,xi)+gfx(datcolor2(:,zi));
 D(:,2)=datcolor2(:,yi)+gfy(datcolor2(:,zi));
 D(:,3)=datcolor2(:,zi);
 E=datcolor1(:,[xi,yi,zi]);
 F=datcolor2(:,[xi,yi,zi]);

 mmse=mse_voll(D,E);

    scrsz = get(0,'ScreenSize');

       figure
       set(gcf,'Position',[scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]);
            whitebg('k')
            plot(E(:,1),E(:,2),'*b')
            hold on  
            grid on
            plot(D(:,1),D(:,2),'or')
            plot(datcolor1(:,cenxi),datcolor1(:,cenyi),'.w')
           % plot(F(:,1),F(:,2),'.m')
       title(['Registration color2 (o red) to color1 (* blue) (white-centroids of color1). MSE= ',num2str(mmse)])



figure
whitebg('w')
grid on
whitebg('w')
hold on
plot(zz,xx,'-g')
hold on
plot(zz,xx,'.k')
grid on
plot(zz,gfx(zz),'-b','linewidth',2)
legend('Shift of frame2frame','Shift interpolation')
title(['Calibration  frame2frame: X-shift interpolation. MSE ',num2str(gox.rmse)])
xlabel(' z in nm')
ylabel('Calibration: X-shift  in nm')

figure

plot(zz,yy,'-g')
hold on
plot(zz,yy,'.k')
plot(zz,gfy(zz),'-b','linewidth',2)
legend('Shift of frame2frame','Shift interpolation')
title(['Calibration  frame2frame: Y-shift interpolation. MSE ',num2str(goy.rmse)])
xlabel(' z in nm')
grid on
ylabel('Calibration: Y-shift  in nm')
 lo=min(gfy(zz));
 lo=min(lo,-100);
 op=max(gfy(zz));
 op=max(op,100);
 




figure
hold on
grid on
for i=1:size(zz,2)
    line( [zz(i),gfx(zz(i))+zz(i)],[0,gfy(zz(i))])
end
title(['Calibration  frame2frame: Interpolated displacement vectors \newline MSE = ', num2str(mmse),' nm'])
xlabel(' z in nm')
ylabel('Displacement vectors in nm')
ylim([lo,op])
