

[data1,xg1,yg1,segxi,segyi]=z_sector_calcul(datcolor1g,grid_size,sizeMcolor1(1),sizeMcolor1(2),cenxi,cenyi,xi,yi,zi);                                     
pause(1)
[data2,xg2,yg2,segxi,segyi]=z_sector_calcul(datcolor2g,grid_size,sizeMcolor2(1),sizeMcolor2(2),cenxi,cenyi,xi,yi,zi);                                    

%figure
%plot(data1(:,cenxi),data1(:,cenyi),'ob')
%hold on 
%plot(data2(:,cenxi),data2(:,cenyi),'or')
%plot_grid(grid_size,xg1,yg1)
stop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MPO=[];

global PM
global PF
global transit
transit=1;
 TC=[];
 TO=[];
for i=1:grid_size
   for k=1:grid_size 
       ep1=find(data1(:,segxi)==i & data1(:,segyi)==k);
       x1=data1(ep1,xi);
       y1=data1(ep1,yi);
       pos1=[x1,y1];
       
       ep2=find(data2(:,segxi)==i & data2(:,segyi)==k);
       x2=data2(ep2,xi);
       y2=data2(ep2,yi);
       pos2=[x2,y2];
       
       
       figure(50)
       scrsz = get(0,'ScreenSize');

      
       %subplot('Position',[0.04, 0.11, 0.45, 0.8])
       

      plot(data1(:,cenxi),data1(:,cenyi),'.w')
       hold on
       plot_grid(grid_size,xg1,yg1)
       %plot(data2(:,cenxi),data2(:,cenyi),'or')
       plot(x1,y1,'.b')
       hold on
       %plot(x2,y2,'.r')
       xlim([0,sizeMcolor1(1)])
       ylim([0,sizeMcolor1(2)])
       pause(0.01)
        title('Registration color2 (red) to color1 (blue)')
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     
      
       PM=pos2;
       PF=pos1;
       ind = sub2ind([grid_size,grid_size],i,k);
   if isempty(PM) || isempty(PF)
       v=[];
       v(1:7,1)=0;
       v(8,1)=ind; 
       v(9,1)=i; 
       v(10,1)=k; 
       TO=[TO,v];
       TC=[TC,v];
       else
   Global_Point_Cloud_trasns;
       PMc =zaz_correction_mobile_RT(Rc,tc,PM);
       PMo =zaz_correction_mobile_RT(Ro,to,PM);
       
       plot(PMo(:,1),PMo(:,2),'or')
      
       MPO=[MPO',PMo']';  
   end    
       
  end
         
end
clc

msee=mse_voll(MPO,data1(:,[xi,yi]));
disp(['MSE = ',num2str(msee)])
TO=z_TF_full(TO);
TC=z_TF_full(TC);
plot_displacement(grid_size,xg1,yg1,sizeMcolor1(1),sizeMcolor1(2),TO)
answer_repeat_calibration;