function plot_dryft(SHG,titel)
figure
whitebg('w')
grid on
plot(SHG(:,5),SHG(:,1),'-r')
hold on
plot(SHG(:,5),SHG(:,2),'-b')
legend('shift x','shift y')
xlabel('Z in nm')
ylabel('shift in nm')
title(['Accumulated shift:',titel])