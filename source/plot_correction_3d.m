
scrsz = get(0,'ScreenSize');

figure('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.99 scrsz(4)/1.25]) ;


whitebg('k')
plot3(datao(:,xi),datao(:,yi),datao(:,zi),'ob','markersize',6)
hold on 
plot3(dataf(:,xi),dataf(:,yi),dataf(:,zi),'.y','markersize',8)
legend('before cottection','after correction')
title ('Data after correction')
clear('scrsz','eppp','eppn','zz1','zz2')