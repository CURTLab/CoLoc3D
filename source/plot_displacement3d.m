function plot_displacement3d(grid_size,xg,yg,sizemaxX,sizemaxY,TT)

 alpp=5;
 scrsz = get(0,'ScreenSize');


figure ('OuterPosition', [scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;


 whitebg('w')
 plot_grid(grid_size,xg,yg)
 hold on
 deltax=xg(2)- xg(1);
 deltay=yg(2)- yg(1);
 xlim([0,sizemaxX])
 ylim([0,sizemaxY])
 zlim([-3000,3000])
 title(['Displacement field of color2 to color1 3D. Scale ',num2str(alpp)])
 for ii=1:grid_size
     for kk=1:grid_size
         y1=[];
         x1=[];
         z1=[];
         y2=[];
         x2=[];
         z2=[];
                
         plot(xg(ii)+0.5*deltax,yg(kk)+0.5*deltay,'or','markersize',1,'markerfacecolor','r')
         hold on
         x1=xg(ii)+0.5*deltax;
         y1=yg(kk)+0.5*deltay;
         z1=0;
         
          ey=find(TT(15,:)==ii & TT(16,:)==kk);
            tx=TT(10,ey);
            ty=TT(11,ey);
            tz=TT(12,ey);
            x2=x1+tx*alpp;
            y2=y1+ty*alpp;
            z2=z1+tz*alpp;
          %line([x1 x2],[y1 y2],'color','b','linewidth',1)
           plot3([x1 x2],[y1 y2],[z1,z2],'-r','linewidth',1.5)
           grid on
     end
     view(20,5)
    
 end