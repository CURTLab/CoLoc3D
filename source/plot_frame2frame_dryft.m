D=[];
for ii=1:Nmax
    D(ii,1)=sum(F_Shift(1:ii,3));
    D(ii,2)=sum(F_Shift(1:ii,4));
end
figure
whitebg('w')
plot(F_Shift(:,7),D(:,1),'-r')
hold on
plot(F_Shift(:,7),D(:,2),'-b')
legend('shift x','shift y')
grid on
xlabel('Z in nm')
ylabel('Shift in nm')
title('accumulated shift frame2frame')