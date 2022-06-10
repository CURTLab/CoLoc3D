 
 dt1ou=datcolor1g;
 dt2ou=datcolor2f;

 close all

[data1,xg1,yg1,segxi,segyi]=z_sector_calcul(dt1ou,grid_size,sizeMcolor1(1),sizeMcolor1(2),cenxi,cenyi,xi,yi,zi);                                     
clc
disp('sectors channel 0')

pause(0.5)
close
[data2,xg2,yg2,segxi,segyi]=z_sector_calcul(dt2ou,grid_size,sizeMcolor2(1),sizeMcolor2(2),cenxi,cenyi,xi,yi,zi);                                    
clc
disp('sectors channel 1')
pause(0.5)
close





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
       shx=DSq(ep2,1);
       shy=DSq(ep2,2);
       shz=DSq(ep2,3);
 %%%%%%%%%%%%%%%%%%%%%%%%%%% outliers elimination      
       DSqq=DSq(ep2,:);
       ep22=find(DSqq(:,6)==0);
       shx2=DSqq(ep22,1);
       shy2=DSqq(ep22,2);
       shz2=DSqq(ep22,3);
       pos22=DSqq(ep22,7:9);
        x22=DSqq(ep22,7);
        y22=DSqq(ep22,8);
        z22=DSqq(ep22,9);
       
       
       
           scrsz = get(0,'ScreenSize');

       figure(50)
       set(gcf,'Position',[scrsz(3)/6 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]);

      
       %subplot('Position',[0.04, 0.11, 0.45, 0.8])
       plot(data1(:,cenxi),data1(:,cenyi),'.w')
       hold on
       plot_grid(grid_size,xg1,yg1)
       %plot(data2(:,cenxi),data2(:,cenyi),'or')
       hold on
       plot(x1,y1,'*b')
       hold on
       %plot(x22,y22,'.g')
       xlim([0,sizeMcolor1(1)])
       ylim([0,sizeMcolor1(2)])
       pause(0.01)
       title('Registration color2 (o red) to color1 (* blue).\newline(white-centroids of color1, square cyan-outliers in color2')
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
      
     ind = sub2ind([grid_size,grid_size],i,k);
     if isempty(pos22)                                   % || isempty(pos1)
        [Ro,to]=vector2RT(shm(1:3)) ;
         v=[];
       %%%%%%%%%%%%%%%%%%% save result in TO %%%%%%%%%%%%%%%
         v=rigid2vector(Ro,to);
         winkel=rad2deg(asin(v(2)));                           %%%%% row 13
         v=[v',winkel,ind,i,k]';
         TO=[TO,v];
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
         if isempty(pos2)==0 && isempty(pos22)==1
              PMo1 =zaz_correction_mobile_RT(Ro,to,pos2);
              MPO=[MPO',PMo1']'; 
              plot(PMo1(:,1),PMo1(:,2),'sqc')
         end
             
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     else
         s=[mean(shx2),mean(shy2),mean(shz2)];
         [Ro,to]=vector2RT(s) ;
         v=[];
       %%%%%%%%%%%%%%%%%%% save result in TO %%%%%%%%%%%%%%%
         v=rigid2vector(Ro,to);
         winkel=rad2deg(asin(v(2)));       %%%%% row 13
         v=[v',winkel,ind,i,k]';
         TO=[TO,v];
         
     
       PMo =zaz_correction_mobile_RT(Ro,to,pos2);
       PMo2 =zaz_correction_mobile_RT(Ro,to,pos22);
        
       plot(PMo(:,1),PMo(:,2),'sqc')
       plot(PMo2(:,1),PMo2(:,2),'or')
       
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
disp(['MSE = ',num2str(msee)])

answer_repeat_calibration_p;





%%%%%%%%%%%%%  
%plot_beide;