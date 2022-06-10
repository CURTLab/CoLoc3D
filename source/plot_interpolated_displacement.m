figure
hold on
plot(zz,xx,'-g')
hold on
plot(zz,xx,'.k')
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
ylabel('Calibration: Y-shift  in nm')
 lo=min(gfy(zz));
 lo=min(lo,-100);
  op=max(gfy(zz));
 op=max(op,100);
figure
hold on
for i=1:size(zz,2)
    line( [zz(i),gfx(zz(i))+zz(i)],[0,gfy(zz(i))])
end
title('Calibration  frame2frame: Interpolated displacement vectors')
xlabel(' z in nm')
ylabel('Displacement vectors in nm')
ylim([lo,op])