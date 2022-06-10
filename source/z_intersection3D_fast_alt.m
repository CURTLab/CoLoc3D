clc
if exist('alpha','var')==0
alpha=5;
end
alpha=2
offset=size(pos1,1);
p1min=1;
p1max=offset;
lang=size(pos2,1);
p2min=offset+1;
p2max=offset+lang;
pos=[pos1',pos2']';
N=size(pos,1);
coloc=[];
PCOL_2=[];
disp('Distance calculation: Please wait')
tic
    %[~,avg_min_dist]=distmin_NN(pos);
    %[avg_min_dist,~]=estimation_min_dist(pos);
    avg_min_dist=max(avg_min_dist1,avg_min_dist2);
toc
tic
disp('Cluster calculation DBSCAN. Please wait')

cidx = dbscan(pos,alpha*avg_min_dist,4);
M0=max(cidx);
toc

cidx1=cidx(1:p1max,:);
cidx2=cidx(p2min:p2max,:);
e1=find(cidx1>0);
cid1=cidx1(e1,:);
e1=find(cidx2>0);
cid2=cidx2(e1,:);
cid1=unique(cid1,'rows');
cid2=unique(cid2,'rows');
M1=numel(cid1);
M2=numel(cid2);
Cl = intersect(cid1,cid2);

pozycja1=[0.05, 0.3,0.9,0.65];
pozycja2= [0.15, 0.05,0.7,0.15];

scrsz = get(0,'ScreenSize');
figure(100)
whitebg('k')
set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);
subplot('position',pozycja1)
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.b','markersize',2)
hold on
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.r','markersize',2)
view(2)
axis image
xlim([min(pos1(:,1)),max(pos1(:,1))+1000])
subplot('position',pozycja2)
grid on
hold on
xlim([0,numel(Cl)+1])
%ylim([0,110])
title('Collocation size in %')

for j=1:numel(Cl)
    
    e1=find(cidx1==Cl(j));
    e2=find(cidx2==Cl(j));
    
    if numel(e1)>3 && numel(e2)>3
       
     hull1=pos1(e1,:);
     [C1,v1] = convhulln(hull1);
     poly1=hull1(C1,:);
     area1=v1;
   
     hull2=pos2(e2,:);
     [C2,v2] = convhulln(hull2);
     poly2=hull2(C2,:);
     area2=v2;
      
     PCOL_2=[PCOL_2',hull2']';
     ve(1,1)= Cl(j);
     ve(2,1)= area1;
     ve(3,1)= area2;
     ve(4,1)= (min(area2,area1)/(area1+area2))*100;
     ve(5,1)= numel(e1);
     ve(6,1)=numel(e2);
     coloc=[coloc,ve];
     
    figure(100)
    subplot('position',pozycja1)

   trisurf(C1,hull1(:,1),hull1(:,2),hull1(:,3),'FaceColor','b','FaceAlpha',0.3)
       hold on
   trisurf(C2,hull2(:,1),hull2(:,2),hull2(:,3),'FaceColor','w','FaceAlpha',0.4)
    plot3(hull2(:,1),hull2(:,2),hull2(:,3),'.w','markersize',6)
    plot3(hull2(:,1),hull2(:,2),hull2(:,3),'.r','markersize',4)
    grid on
    title('Cluster collocations. White - clusters of sample 2 collocated to sample 1')
   subplot('position',pozycja2)
   bar(j,ve(4,1),'r')
   end
    

end
coloc=coloc';
tt=['col_fast_alph_',num2str(alpha),'.mat'];
save(tt,'coloc','avg_min_dist','PCOL_2','M0','M1','M2');
collocation_both_methods;