


scrsz = get(0,'ScreenSize');

figure('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.99 scrsz(4)/1.25]) ;


whitebg('k')
plot(datao(:,xi),datao(:,yi),'ob','markersize',6)
hold on 
plot(dataf(:,xi),dataf(:,yi),'.y','markersize',8)
legend('before cottection','after correction')
title ('Data after correction')
clear('scrsz','eppp','eppn','zz1','zz2')