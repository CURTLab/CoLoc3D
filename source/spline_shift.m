
function [sh_x,sh_y,xx]=spline_shift(F_Shift,Nmax,Zero)           

xx=1:1:Nmax;
xxx=(xx-Zero)*10;
xx=xx';
shx=F_Shift(:,3);
shy=F_Shift(:,4);

options = fitoptions('Method','SmoothingSpline',...
                     'SmoothingParam',0.7);

sh_x=fit(xx,shx,'smoothingspline',options); % fit standard matlab function
sh_y=fit(xx,shy,'smoothingspline',options);
figure
whitebg('w')
plot(xxx,shx,'-g')
hold on
plot(xxx,sh_x(xx),'-k')
grid on
xlabel('Z  in nm')

title('frame2fram2 shift x')
figure
whitebg('w')
plot(xxx,shy,'-g')
hold on
grid on
xlabel('Z  in nm')
plot(xxx,sh_y(xx),'-k')
title('frame2frame shift y')
end