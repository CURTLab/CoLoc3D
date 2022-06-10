


close all

[data1,xg1,yg1,segxi,segyi]=z_sector_calcul(datcolor1g,grid_size,sizeMcolor1(1),sizeMcolor1(2),cenxi,cenyi,xi,yi,zi);                                     

disp('sectors channel 0')
pause(0.01)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5  2f  or 2fs 
close
[data2,xg2,yg2,segxi,segyi]=z_sector_calcul(datcolor2f,grid_size,sizeMcolor2(1),sizeMcolor2(2),cenxi,cenyi,xi,yi,zi);                                    
clc
disp('sectors channel 1')
pause(0.01)
close
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of preparation2calibration 
 uu=pdist2(data1(:,[xi,yi,zi]),data2(:,[xi,yi,zi]));
 mdist0=median(min(uu));
 mdist0=max(mdist0,500); %%%%%%%%%%%%%%%% max local displacement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global PM
global PF


 TO=[];
 MPO=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:grid_size
   for k=1:grid_size 
       ep1=find(data1(:,segxi)==i & data1(:,segyi)==k);
       
       x1=data1(ep1,xi);
       y1=data1(ep1,yi);
       z1=data1(ep1,zi);
       pos1=[x1,y1,z1];
     
       ep2=find(data2(:,segxi)==i & data2(:,segyi)==k);
       x2=data2(ep2,xi);
       y2=data2(ep2,yi);
       z2=data2(ep2,zi);
       pos2=[x2,y2,z2];

           scrsz = get(0,'ScreenSize');

       figure(50)
       set(gcf,'Position',[scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]);

      
       %subplot('Position',[0.04, 0.11, 0.45, 0.8])
       plot(data1(:,cenxi),data1(:,cenyi),'.w')
       hold on
       plot_grid(grid_size,xg1,yg1)
       %plot(data2(:,cenxi),data2(:,cenyi),'or')
       hold on
       plot(x1,y1,'.b','markersize',8)
       hold on
      % plot(x2,y2,'+g')
       xlim([0,sizeMcolor1(1)])
       ylim([0,sizeMcolor1(2)])
       pause(0.05)
       title('Calibration color2 (o red) to color1 (* blue) \newline (white-centroids of color1, square cyan-outliers in color2)')
  %%%%%%%%%%%%%%n%%%%%%%%%%%%%%%%%%%%%%%%% 
   
      
       PM=pos2;
       PF=pos1;
       ind = sub2ind([grid_size,grid_size],i,k);
   if isempty(PM) || isempty(PF)
       [Ro,to]=vector2RT(shm(1:3)) ;
             v=[];
        
       %%%%%%%%%%%%%%%%%%% save result in TO %%%%%%%%%%%%%%%
         v=rigid2vector(Ro,to);
         winkel=rad2deg(asin(v(2)));       %%%%% row 13
         v=[v',winkel,ind,i,k]';
         TO=[TO,v];
         %%%%%%%%%%%%%%%%%%%%%%%
          if isempty(PM)==0
           PMo =zaz_correction_mobile_RT(Ro,to,PM);
          % plot(PMo(:,1),PMo(:,2),'sqc')
           MPO=[MPO',PMo']'; 
          end
   else
       Global_Point_Cloud_trasns;
    
       PMo =zaz_correction_mobile_RT(Ro,to,PM);
       
        
       plot(PMo(:,1),PMo(:,2),'or','linewidth',1.0)
      
      
       MPO=[MPO',PMo']';  
   end    
       
  end
         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msee=mse_voll(MPO,data1(:,[xi,yi,zi]));
disp(['MSE = ',num2str(msee)])
%TO=z_TF_full(TO);
plot_calib;
plot_displacement3d(grid_size,xg1,yg1,sizeMcolor1(1),sizeMcolor1(2),TO)
plot_displacement(grid_size,xg1,yg1,sizeMcolor1(1),sizeMcolor1(2),TO)

answer_repeat_calibration;






%%%%%%%%%%%%%  
%plot_beide;