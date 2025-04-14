cenOverStan=[];
if isempty(colocat)==0
em=size(colocat,1);
for lk=1:em
   ek=find(klaster2(:,1)==colocat(lk,1)); %%calculatino of centroids for collocated cluster 2
    if numel(ek)==1
       cenOverStan(lk,:)=pos2(ek,:);
    else
        cenOverStan(lk,:)=mean(pos2(ek,:)); % centroids for collocated cluster
    end 
end

poinFixOverStan=[];
for lk=1:em
    ek=find(klaster1(:,1)==colocat(lk,2)); %%calculatino of points fix for collocated cluster 2
    u=pos1(ek,:);
    poinFixOverStan=[poinFixOverStan',u']';
end
end

scrsz = get(0,'ScreenSize');
figure(400)
whitebg('k')
set(gcf,'InnerPosition',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.8]);
axis image
whitebg('w')
plot(pos1(:,1),pos1(:,2),'.c','markersize',6);
hold on
plot(pos2(:,1),pos2(:,2),'.r','markersize',8);
hold on
if isempty(PCOL_1)==0
plot(PCOL_1(:,1),PCOL_1(:,2),'or','markersize',12,'linewidth',2)
end
%plot(cenOverStan(:,1),cenOverStan(:,2),'.b','markersize',10,'markerfacecolor','b')
if isempty(colocat)==0
plot(poinFixOverStan(:,1),poinFixOverStan(:,2),'.b','markersize',3,'markerfacecolor','b')
end


grid on
%%%%%%%%%%%%%%%%%%%%% fix collocated points %%%%%%%%%%%%%%%

poinFixOverFast=[];
if isempty(coloc)==0
enn=size(coloc,1);
for lk=1:enn
ukk=find(cidx(:,1)==coloc(lk,1));
up=pos(ukk,:);
poinFixOverFast=[poinFixOverFast',up']';
end
end

hold on
if isempty(coloc)==0
plot(poinFixOverFast(:,1),poinFixOverFast(:,2),'.b','markersize',2,'markerfacecolor','b')
end
if isempty(PCOL_2)==0
plot(PCOL_2(:,1),PCOL_2(:,2),'ok','markersize',5,'markerfacecolor','y','linewidth',1)
end
if isempty(PCOL_1)==0
plot(PCOL_1(:,1),PCOL_1(:,2),'or','markersize',12,'linewidth',1)
end



legend('Passive cloud','Active Cloud','coll Standard Method','coll fix points','coll fix points','coll Sensitive Method ')
%axis image
title(['\rm Comparison of collocated points from active sample2 (METHOD 1-Standard and METHOD 2-Sensitive)',...
    '\newline METHOD-1:Volumetric average IoU= ',num2str(round(Qp*100,2)),' %',...
    ', Quantitative average collocation = ',num2str(round(QNp*100,2)),' %',...
    '\newline METHOD-2: Volumetric average IoU =',num2str(round(Qf*100,2)),' %',...
    ', Quantitative average collocation=',num2str(round(QNf*100,2)),' %',...
    ' \newline  Sample1: ',exname1,', Sample2: ',exname2],'color','k') 
xlabel(['nm.  Clustering radius:  ',num2str(RRR),' nm'])
ylabel('nm')





