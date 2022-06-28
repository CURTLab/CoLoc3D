
clc
clear
close all

Data_Load_1;

Data_Load_2
%close all
%cccccccccccccccccccc;

alpha=2;


pos1=dat1(:,[xi1,yi1,zi1]);
[klaster1,centroid1,kcentroid1,avg_min_dist1,N1]=cluster_preparation3D(pos1,alpha);

alpha2=5;
close all
pos2=dat2(:,[xi2,yi2,zi2]);
[klaster2,centroid2,kcentroid2,avg_min_dist2,N2]=cluster_preparation3D(pos2,alpha2);


Answer_coll_typ;
 

 
 
