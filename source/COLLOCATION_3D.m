clc
warning off
curr=0;
if exist('pos1','var')==1 && exist('pos2','var')==1
answer_new_sample;
end

if curr==0
clc
clear
close all

try
Data_Load_1;
Data_Load_2
catch
disp('Loading error')
A_start;
end

end
stop2;
clear('PCOL_1','PCOL_2')

pos1=dat1(:,[xi1,yi1,zi1]);
pos2=dat2(:,[xi2,yi2,zi2]);

plot_obie;

disp('Calculation of Average min distance. Please wait')

 [amd1,~]=estimation_min_dist(pos1);
 [amd2,~]=estimation_min_dist(pos2);
 amd1=round(amd1);
 amd2=round(amd2);
 amd=max(amd1,amd2);

 answer_alpha;
 alpha=RRR/amd1;
 alpha2=RRR/amd2;

pause(1)
%pos1=dat1(:,[xi1,yi1,zi1]);
%pos2=dat2(:,[xi2,yi2,zi2]);
disp(['Radius = ',num2str(RRR)])
RRR1=RRR;
RRR2=RRR;

[klaster1,centroid1,kcentroid1,avg_min_dist1,N1]=cluster_preparation3D(pos1,alpha);
RRR1=alpha*avg_min_dist1;
[klaster2,centroid2,kcentroid2,avg_min_dist2,N2]=cluster_preparation3D(pos2,alpha2);
RRR2=alpha2*avg_min_dist2;

try
Answer_coll_typ;
catch
    A_start;
end

 
 
