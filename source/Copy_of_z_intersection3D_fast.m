clc
alpha=2.0;

clear('C1','C2','C3','C000','DISTANCEFast','Cl');
hull_distance=[];
cid2centr=[];
cid1centr=[];
coloc=[];
PCOL_2=[];

POSY1=pos1;
POSY1(:,4)=1;
POSY2=pos2;
POSY2(:,4)=2;


%offset=size(pos1,1);
%p1min=1;
%p1max=offset;
%lang=size(pos2,1);
%p2min=offset+1;
%p2max=offset+lang;

pos=[pos1',pos2']';
POSY=[POSY1',POSY2']';
N=size(pos,1);

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

%cidx1=cidx(1:p1max,:);
%cidx2=cidx(p2min:p2max,:);


eo=find(POSY(:,4)==1);
cidx1=cidx(eo,:);
eo=find(POSY(:,4)==2);
cidx2=cidx(eo,:);

%%%%%%%%%%%%%%%%%%%% Figure Parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%
pozycja1=[0.05, 0.3,0.9,0.65];
pozycja2= [0.15, 0.05,0.7,0.15];
scrsz = get(0,'ScreenSize');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(100)
whitebg('k')
set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);
subplot('position',pozycja1)
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.b','markersize',2)
hold on
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.r','markersize',2)
view(2)
axis image
hh=text(2*min(pos1(:,1)),4*min(pos1(:,2))+1000, ['Cluster ',num2str(1),'/',num2str(10)],'color','k');
aa=min(min(pos1(:,1)),min(pos2(:,1)));
bb=max(max(pos1(:,1)),max(pos2(:,1)));

%xlim([min(pos1(:,1)),max(pos1(:,1))+1000])
xlim([aa,bb+1000])
subplot('position',pozycja2)
grid on
hold on
%ylim([0,110])
title('Collocation size in %')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e1=find(cidx1>0);
cid1=cidx1(e1,:);
e1=find(cidx2>0);
cid2=cidx2(e1,:);

cid1=unique(cid1,'rows');
cid2=unique(cid2,'rows');
M1=numel(cid1);
M2=numel(cid2);
cid1centr=cid1;


for kk=1:M1
disp(['Drawing fix cluster ',num2str(kk),'/',num2str(M1)])
eoo=find(cidx1(:,1)==cid1(kk));
hullo=pos1(eoo,:);
if numel(eoo)> 1
cent=mean(hullo);
else
cent=hullo;
end

cid1centr(kk,2)=cent(:,1);
cid1centr(kk,3)=cent(:,2);
cid1centr(kk,4)=cent(:,3);

if numel(eoo)>3
[C000,~] = convhulln(hullo);

figure(100)
subplot('position',pozycja1)
grid on
plot3(hullo(:,1),hullo(:,2),hullo(:,3),'.b','markersize',3)
hold on
if exist('C000','var')==1
trisurf(C000,hullo(:,1),hullo(:,2),hullo(:,3),'FaceColor','b','FaceAlpha',0.4)
end
end
delete(hh)
hh=text(2*min(pos1(:,1))+100,4*min(pos1(:,2))+1000, ['Cluster fix ',num2str(kk),'/',num2str(M1)],'color','r');
end

cid2centr=cid2;
for kk=1:M2
disp(['Drawing mobile cluster ',num2str(kk),'/',num2str(M2)])
eoo=find(cidx2(:,1)==cid2(kk));
hullo=pos2(eoo,:);
poax2=mean(dat2(eoo,sxi2));
poaz2=mean(dat2(eoo,szi2));
poa2=sqrt((2*poax2^2+poaz2^2)/3);

if numel(eoo)> 1
cent=mean(hullo);
else
cent=hullo;
end
cid2centr(kk,2)=cent(:,1);
cid2centr(kk,3)=cent(:,2);
cid2centr(kk,4)=cent(:,3);

%%%%%%%% nearest neighbor %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

WW=pdist2(cid2centr(kk,2:4),cid1centr(:,2:4));
et=find(WW==min(WW),1,'first');
ett=find(cidx1(:,1)==cid1(et));
ho=pos1(ett,:);
poax1=mean(dat1(ett,sxi1));
poaz1=mean(dat1(ett,szi1));
poa1=sqrt((2*poax1^2+poaz1^2)/3);
aq=pdist2(hullo,ho);
aq=min(min(aq));
WW=min(min(WW));
cid2centr(kk,5)=WW;
cid2centr(kk,6)=aq;
cid2centr(kk,7)=poa2;
cid2centr(kk,8)=et;
cid2centr(kk,9)=poa1;

%%%%%%%% nearest neighbor  end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

if numel(eoo)>3
[C000,~] = convhulln(hullo);

figure(100)
subplot('position',pozycja1)
grid on
plot3(hullo(:,1),hullo(:,2),hullo(:,3),'.r','markersize',3)
hold on
if exist('C000','var')==1
trisurf(C000,hullo(:,1),hullo(:,2),hullo(:,3),'FaceColor','r','FaceAlpha',0.4)
end
end

delete(hh)
hh=text(2*min(pos1(:,1))+100,4*min(pos1(:,2))+1000, ['Cluster mobil ',num2str(kk),'/',num2str(M2)],'color','r');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%intersection%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cl = intersect(cid1,cid2);

overlapp=0;
PCOL_2=[];
for j=1:numel(Cl)
disp(['intersection search ',num2str(j),'/',num2str(size(Cl,1))])
    
   
    e1=find(cidx1==Cl(j));
    e2=find(cidx2==Cl(j));
    e3=find(cid2centr(:,1)==Cl(j));%,1,'first');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
       
      hull1=pos1(e1,:);
      hull2=pos2(e2,:);   
        %%%%%%%%%%%%%%%%%% parameter distance ans PA
         absMin=pdist2(hull2,hull1);
         absMin=min(min(absMin));
         poax1=mean(dat1(e1,sxi1));
         poaz1=mean(dat1(e1,szi1));
         poa1=sqrt((2*poax1^2+poaz1^2)/3);
         poax2=mean(dat2(e2,sxi2));
         poaz2=mean(dat2(e2,szi2));
         poa2=sqrt((2*poax2^2+poaz2^2)/3);
         cid2centr(e3,6)=absMin;
         cid2centr(e3,7)=poa2;
         cid2centr(e3,8)=Cl(j);
         cid2centr(kk,9)=poa1;
      
 %%%%%%%%%%%%%%%%%%%%%intersection %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
     if numel(e1)>3 && numel(e2)>3
         overlapp=1;
         disp('INTERSECTION')
     [C1,v1] = convhulln(hull1);
     poly1=hull1(C1,:);
     [C2,v2] = convhulln(hull2);
     poly2=hull2(C2,:);
 
     PCOL_2=[PCOL_2',hull2']';
     ve(1,1)= Cl(j);
     ve(2,1)= v1;
     ve(3,1)= v2;
     ve(4,1)= (min(v2,v1)/(v1+v2))*100;
     ve(5,1)= numel(e1);
     ve(6,1)= numel(e2);
     coloc=[coloc,ve];
    
     elseif numel(e1)>3 && numel(e2)==300000000000
         overlapp=1;
     [C1,v1] = convhulln(hull1);
     poly1=hull1(C1,:);    
     poly2=hull2;
     v2=(4*pi*(avg_min_dist2/2)^3)/3;
     v2=numel(e2)*v2;    
     PCOL_2=[PCOL_2',hull2']';
     ve(1,1)= Cl(j);
     ve(2,1)= v1;
     ve(3,1)= v2;
     ve(4,1)= (min(v2,v1)/(v1+v2))*100;
     ve(5,1)= numel(e1);
     ve(6,1)= numel(e2);
     coloc=[coloc,ve];   
        
     elseif numel(e1)==3 && numel(e2)>30000000000
         overlapp=1;
     [C2,v2] = convhulln(hull1);
     poly2=hull2(C2,:);    
      
     poly1=hull1;
     v1=(4*pi*(avg_min_dist1/2)^3)/3;
     v1=numel(e1)*v1;    
     PCOL_2=[PCOL_2',hull2']';
     ve(1,1)= Cl(j);
     ve(2,1)= v1;
     ve(3,1)= v2;
     ve(4,1)= (min(v2,v1)/(v1+v2))*100;
     ve(5,1)= numel(e1);
     ve(6,1)= numel(e2);
     coloc=[coloc,ve];       
  end        
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      if overlapp==1
      if cid2centr(e3,6)<=1.0*(cid2centr(e3,7)+cid2centr(e3,9))
            cid2centr(e3,5)=-cid2centr(e3,5);
            cid2centr(e3,6)=-cid2centr(e3,6);
      end   
      end   
         
    
    
    figure(100)
    subplot('position',pozycja1)
    if exist('C1','var')==1
    trisurf(C1,hull1(:,1),hull1(:,2),hull1(:,3),'FaceColor','c','FaceAlpha',0.4)
    hold on
    %plot3(hull1(:,1),hull1(:,2),hull1(:,3),'og','markersize',3,'markerfacecolor','b')
    else
     %hte=[hull1',hull1(1,:)']';
     %plot3(hte(:,1),hte(:,2),hte(:,3),'-oc','markersize',3,'markerfacecolor','b')
     hold on
     %plot3(hull1(:,1),hull1(:,2),hull1(:,3),'ok','markersize',3,'markerfacecolor','b')
    end
    hold on
   if exist('C2','var')==1
   trisurf(C2,hull2(:,1),hull2(:,2),hull2(:,3),'FaceColor','r','FaceAlpha',1)
    hold on
   plot3(hull2(:,1),hull2(:,2),hull2(:,3),'ow','markersize',7,'markerfacecolor','r') 
   else
    %hte=[hull2',hull2(1,:)']';
    %plot3(hte(:,1),hte(:,2),hte(:,3),'-ow','markersize',3,'markerfacecolor',' r')
    %hold on
   % plot3(hull2(:,1),hull2(:,2),hull2(:,3),'or','markersize',4,'markerfacecolor','r') 
   end
  
 grid on
   title('Cluster collocations. White - clusters of sample 2 collocated to sample 1')
   subplot('position',pozycja2)
   xlim([0,M2+1])
   bar(j,ve(4,1),'r')
end
    




coloc=coloc';

tt=['col_fast_alph_',num2str(alpha),'.mat'];
save(tt,'coloc','avg_min_dist','PCOL_2','M0','M1','M2');
%collocation_both_methods;
A_excel_sensiv;
A_excel_distance_sens;