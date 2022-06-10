
 
function [data,xg,yg,segxi,segyi]=z_sector_calcul(data,grid_size,sizemaxX,sizemaxY,cenxi,cenyi,xi,yi,zi)                                       
close
sizMx=sizemaxX;
sizMy=sizemaxY;

lastgi=size(data,2);

xg=[];
yg=[];
for i=1:grid_size
    xg(i+1)=round(((1/grid_size)*i),3)*sizMx;
    yg(i+1)=round(((1/grid_size)*i),3)*sizMy;
end

for  i=1:grid_size
%ep=find(data(:,cenxi)>xg(i) & data(:,cenxi)<=xg(i+1) );
ep=find(data(:,xi)>xg(i) & data(:,xi)<=xg(i+1) );

data(ep,lastgi+1)=i;
end
segxi=lastgi+1;
for  i=1:grid_size
%ep=find(data(:,cenyi)>yg(i) & data(:,cenyi)<=yg(i+1) );
ep=find(data(:,yi)>yg(i) & data(:,yi)<=yg(i+1) );
data(ep,lastgi+2)=i;
end
segyi=lastgi+2;


figure(100)
whitebg('k')
plot3(data(:,xi),data(:,yi),data(:,zi),'.b')
hold on
plot_grid(grid_size,xg,yg)
xlim([0,sizMx+200])
ylim([0,sizMy+200])
title('Sectors and bounding box')
axis image


for i=1:grid_size
   for k=1:grid_size 
       ep=find(data(:,lastgi+1)==i & data(:,lastgi+2)==k);
       x=data(ep,xi);
       y=data(ep,yi);
       plot(x,y,'.w','markersize',5)
       hold on
       plotbox2(x,y,'g')
       pause(0.01)
      % plot_grid(grid_size,xg,yg)

   end
end
       

