
clc
rng('default')
warning('off')
hull_distance_stan=[];
colocat=[];
PCOL_1=[];   %%% collocated points from channel 1

M2=max(klaster2(:,1));  
M1=max(klaster1(:,1));
m1=max(klaster1(:,2));
KNN=min(M1,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%FIG PARAMETER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pozycja1=[0.05, 0.3,0.9,0.65];
pozycja2= [0.15, 0.05,0.7,0.15];
scrsz = get(0,'ScreenSize');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(200)
whitebg('k')
set(gcf,'Position',[scrsz(1)+600,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);
subplot('position',pozycja1)
grid on
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.b','markersize',1.5)
hold on
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.r','markersize',1.5)
view(2)
axis image
hh=text(2*min(pos1(:,1)),4*min(pos1(:,2)), ['Cluster ',num2str(5),'/',num2str(M2)],'color','k');
xlim([min(pos1(:,1)),max(pos1(:,1))+1000])
subplot('position',pozycja2)
hold on
grid on
xlim([0,M2+1])
%ylim([0,110])
title('Cluster collocation size in %')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for lj=1:M1
disp(['Drawing fix cluster ',num2str(lj),'/',num2str(M1)])
eoo=find(klaster1(:,1)==lj);
hullo=pos1(eoo,:);
if numel(eoo)>3
[C000,~] = convhulln(hullo);
figure(200)
subplot('position',pozycja1)
grid on
plot3(hullo(:,1),hullo(:,2),hullo(:,3),'.b','markersize',3)
hold on
if exist('C000','var')==1
trisurf(C000,hullo(:,1),hullo(:,2),hullo(:,3),'FaceColor','b','FaceAlpha',0.4)
end
end
delete(hh)
hh=text(2*min(pos1(:,1))+100,4*min(pos1(:,2))+1000, ['Cluster fix ',num2str(lj),'/',num2str(M1)],'color','r');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






for i=1: M2
disp(['cluster channel1 ',num2str(i),'/',num2str(M2)])
overlap=0;
eo=find(klaster2(:,1)==i);
hull2=pos2(eo,:);
poax2=mean(dat2(eo,sxi2));
poaz2=mean(dat2(eo,szi2));
poa2=sqrt((2*poax2^2+poaz2^2)/3);

%%%%%%% nearest neighbor of cluster 2 and parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D=pdist2(centroid2(i,:),centroid1(:,:));

et=find(D==min(D),1,'first');
ett=find(klaster1(:,1)==et);
poax1=mean(dat1(ett,sxi1));
poaz1=mean(dat1(ett,szi1));
poa1=sqrt((2*poax1^2+poaz1^2)/3);

ho=pos1(ett,:);
aq=pdist2(hull2,ho);
aq=min(min(aq));
WW=min(min(D));

hull_distance_stan(i,2)=WW;     %min to centroid 
hull_distance_stan(i,3)=aq;     %min to point
hull_distance_stan(i,1)=i;      %number clust2
hull_distance_stan(i,5)=et;     %number clust 1
hull_distance_stan(i,4)=poa2;   % PA+PAZ 2
hull_distance_stan(i,6)=poa1;   % PA+PAZ 1
%%%%%%%%%%%%%%%%%
clear('poax1','poax2','poay1','poaz2')



if numel(eo)>3
[C2,v2] = convhulln(hull2);
poly2=hull2(C2,:);
vol2=v2;
else
poly2=hull2;
v2=(4*pi*(avg_min_dist2/2)^3)/3;
v2=numel(eo)*v2;
vol2=v2;

end









figure(200) 

subplot('position',pozycja1)
grid on
plot3(hull2(:,1),hull2(:,2),hull2(:,3),'.r','markersize',3)
hold on
if exist('C2','var')==1
   
trisurf(C2,hull2(:,1),hull2(:,2),hull2(:,3),'FaceColor','r','FaceAlpha',0.4)
else
 plot3(hull2(:,1),hull2(:,2),hull2(:,3),'.r','markersize',3)
 hold on
 hte=[hull2',hull2(1,:)']';
 plot3(hte(:,1),hte(:,2),hte(:,3),'-or','markersize',2,'linewidth',2)%%%%%%%%%%%%

end

%D=pdist2(centroid2(i,:),centroid1)';

huldist=1000000000000000000;

 for j=1:KNN   
  e1=find(D==min(D),1,'first');
      D(e1,:)=10000000;
      e2=find(klaster1(:,1)==e1);
      hull1=pos1(e2,:);
      
    if numel(e2)>3
    [C1,v1] = convhulln(hull1);
    poly1=hull1(C1,:);
    vol1=v1;
    else
    poly1=hull1;
    v1=(4*pi*(avg_min_dist1/2)^3)/3;
    v1=numel(e2)*v1;
    vol1=v1;
    end
    
    min_dist_hullV=dist_hull(poly1,poly2);
    min_dist_hullP=dist_hull(hull1,hull2);
    %disp(['testing cluster1 nr ',num2str(j)]);
        if  min_dist_hullP <= huldist
        huldist=min_dist_hullP;
        NNfound=1;
        else
        NNfound=0;
        %disp('No better')
        end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
 if NNfound==1  
 
  figure(200)
  subplot('position',pozycja1)
  plot3(hull1(:,1),hull1(:,2),hull1(:,3),'.b','markersize',3)
  hold on
  if exist('C1','var')==1
  trisurf(C1,hull1(:,1),hull1(:,2),hull1(:,3),'FaceColor','c','FaceAlpha',0.4)
  else
  plot3(hull1(:,1),hull1(:,2),hull1(:,3),'.b','markersize',3)
  hold on
  hte=[hull1',hull1(1,:)']';
  plot3(hte(:,1),hte(:,2),hte(:,3),'-oc','markersize',3,'linewidth',2)
  end
   
    PU=[];
    in =  inhull(poly2,poly1);
    in2 = inhull(hull2,hull1);
    ein2=find(in2==1);             % points hull-pos2 in hull-pos1
    INTER2=hull2(ein2,:);
    INTER2=unique(INTER2,'rows');

    e=find(in==1);
    PU=[PU',poly2(e,:)']';
    in = inhull(poly1,poly2);
    e=find(in==1);
    PU=[PU',poly1(e,:)']';
    ps=PU;
    ps=unique(ps,'rows');

    if isempty(ps)==0 && size(ps,1)>3
          disp('INTERSECTION')
          overlap=1;
          try
              pp=intersectionHull('vert',poly2,'vert',poly1);
          catch
              bm=max(poly2);  
              poly2=[poly2',bm']'; 
              pp=intersectionHull('vert',poly2,'vert',poly1);
          end
    
              P=pp.vert;
              PCOL_1=[PCOL_1',P']';
              [C3,v3] = convhulln(P);
               stat=1;
               colocatv(1,1)=i;
               colocatv(2,1)=e1;
               colocatv(3,1)=v2;
               colocatv(4,1)=v3;
               colocatv(6,1)= v1;
               colocatv(5,1)= (v3/(v2+v1-v3))*100;
               colocat=[colocat,colocatv];
    
        figure(200)
        subplot('position',pozycja1)
        grid on
        plot3(ps(:,1),ps(:,2),ps(:,3),'ow','markerfacecolor','r','markersize',2)
        hold on
        if exist('C2','var')==1
        trisurf(C2,hull2(:,1),hull2(:,2),hull2(:,3),'FaceColor','m','FaceAlpha',0.4)
        end
        hold on
        if exist('C3','var')==1
       
        trisurf(C3,ps(:,1),ps(:,2),ps(:,3),'FaceColor','w','FaceAlpha',0.4)
        
        end
        subplot('position',pozycja2)
        bar(i,(v3/(v2+v1-v3))*100,'r')
        
   elseif isempty(ps)==0 && size(ps,1)<=3  
         
         C3=[];
         disp('INTERSECTION SMALL')
         overlap=1;
         v3=(4*pi*(avg_min_dist2)^3)/3;
         v3=(size(ps,1))*v3;
         if v3>v2
            v3=v2;
         end
         
         PCOL_1=[PCOL_1',INTER2']';
         
           colocatv(1,1)=i;
           colocatv(2,1)=e1;
           colocatv(3,1)=v2;
           colocatv(4,1)=v3;
           colocatv(5,1)= (v3/(v2+v1-v3))*100;
           colocatv(6,1)= v1;
           colocat=[colocat,colocatv];
           stat=1;    
        figure(200)
        subplot('position',pozycja1)
        plot3(ps(:,1),ps(:,2),ps(:,3),'ow','markerfacecolor','m','markersize',2)
        hold on
        if exist('C3','var')==1
        trisurf(C3,ps(:,1),ps(:,2),ps(:,3),'FaceColor','w','FaceAlpha',0.8)
        end
        hold on
        hte=[ps',ps(1,:)']';
        plot3(hte(:,1),hte(:,2),hte(:,3),'-ow','markersize',2,'markerfacecolor','r','linewidth',2)
        subplot('position',pozycja2)
        bar(i,(v3/(v2+v1-v3))*100,'r')      
  elseif isempty(ps)
      C3=[];
      sqq=pdist2(hull2,hull1);
      sqq=min(min(sqq));
      poa2=hull_distance_stan(i,4);
          poax1=mean(dat1(e2,sxi1));
          poaz1=mean(dat1(e2,szi1));
      poa1=sqrt((2*poax1^2+poaz1^2)/3);

     
      if sqq < 1.1*(poa1+poa2)
           disp('INTERSECTION DISTANCE')
           overlap=1;
           colocatv(1,1)=i;
           colocatv(2,1)=e1;
           colocatv(3,1)=v2;
           colocatv(4,1)=v2;
           colocatv(5,1)= min(v1,v2)/(v2+v1)*100;
           colocatv(6,1)= v1;
           colocat=[colocat,colocatv];
   figure(200)
        subplot('position',pozycja1)
        plot3(hull2(:,1),hull2(:,2),hull2(:,3),'ow','markerfacecolor','r','markersize',2)
        hold on
        if exist('C2','var')==1
        trisurf(C2,hull2(:,1),hull2(:,2),hull2(:,3),'FaceColor','m','FaceAlpha',0.4)
        end
        if exist('C1','var')==1
        trisurf(C1,hull1(:,1),hull1(:,2),hull1(:,3),'FaceColor','c','FaceAlpha',0.4)
        end
        subplot('position',pozycja2)
        bar(i,colocatv(5,1),'r')      
       end
   end
     if overlap==1
     hull_distance_stan(i,3)=-hull_distance_stan(i,3);
     hull_distance_stan(i,2)=-hull_distance_stan(i,2);
     end
 end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delete(hh)
hh=text(2*min(pos1(:,1))+100,4*min(pos1(:,2))+1000, ['Cluster ',num2str(i),'/',num2str(M2)],'color','r');
title('Cluster collocations. White - clusters of sample 2 collocated to sample 1')
 end
end


colocat=colocat';
diamete=colocat(:,[3,4]);
for L=1:size(colocat,1)
   diamete(L,1)=2*nthroot((3*diamete(L,1)/(4*pi)),3);
   diamete(L,2)=2*nthroot((3*diamete(L,2)/(4*pi)),3);
end   
   
   
tt=['col_prec_alph_',num2str(alpha),'.mat'];
save(tt,'colocat','avg_min_dist1','avg_min_dist2','PCOL_1','M1','M2');


collocation_both_methods;


A_excel_stand;
A_excel_distance_stan;

clear('C1','C2','C3','C000');