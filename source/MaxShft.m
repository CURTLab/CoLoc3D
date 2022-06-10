
L=size(TO,2);
for l=1:L
    a=sqrt(TO(10,l)^2+TO(11,l)^2+TO(12,l)^2);
    TO(17,l)=a;
end

meanshift=mean(TO(17,:))
maxshift=max(TO(17,:))

 ek=find(TO(17,:)==maxshift,1,'first');
 im=TO(15,ek) ;
 km=TO(16,ek);
 %im=9
 %km=8
 
  ep1=find(data1(:,segxi)==im & data1(:,segyi)==km);
  x1=data1(ep1,xi);
  y1=data1(ep1,yi);
  z1=data1(ep1,zi);
  cex1=data1(ep1,cenxi);
  cey1=data1(ep1,cenyi);
  cez1=data1(ep1,cenzi);
  ep2=find(data2(:,segxi)==im & data2(:,segyi)==km);
  x2=data2(ep2,xi);
  y2=data2(ep2,yi);
  z2=data2(ep2,zi);
  cex2=data2(ep2,cenxi);
  cey2=data2(ep2,cenyi);
  cez2=data1(ep2,cenzi);
  x3=x2+TO(10,ek);
  y3=y2+TO(11,ek);
  z3=z2+TO(12,ek);
  
  
  figure(700)
  set(gcf,'Position',[scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]);
 plot3(x1,y1,z1,'.b')
 hold on 
 plot3(x2,y2,z2,'*r')
 grid on
 %plot3(cex2,cey2,cez2,'or')
 %plot3(cex1,cey1,cez1,'ob')
  plot3(x3,y3,z3,'om')
  legend('color1 points','color2 before shift','color2 after shift')
  title(['Max shift ',num2str(maxshift),' nm'])