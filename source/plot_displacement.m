 
function plot_displacement(grid_size,xg,yg,sizemaxX,sizemaxY,TT)

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
 title(['Displacement field of color2 to color1. Scale ',num2str(alpp)])
 for ii=1:grid_size
     for kk=1:grid_size
         y1=[];
         x1=[];
         y2=[];
         x2=[];
                
         plot(xg(ii)+0.5*deltax,yg(kk)+0.5*deltay,'or','markersize',3)
         hold on
         x1=xg(ii)+0.5*deltax;
         y1=yg(kk)+0.5*deltay;
         
         
          ey=find(TT(15,:)==ii & TT(16,:)==kk);
            tx=TT(10,ey);
            ty=TT(11,ey);
            x2=x1+tx*alpp;
            y2=y1+ty*alpp;
        
          line([x1 x2],[y1 y2],'color','b','linewidth',1)
         
     end
 end