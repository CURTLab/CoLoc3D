
hull_distance_sens=cid2centr(:,6);
MM=M2H;
hull_distance_sens=sort(hull_distance_sens,'asc');
eee=find(hull_distance_sens<=001,1,'last');
mm=(eee);
clust_overlap_sens=round((mm/MM)*100,2);



scrsz = get(0,'ScreenSize');
figure
whitebg('k')
grid on

set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.8,scrsz(4)*0.63]);

subplot(1,2,1)
grid on
hold on
bar(hull_distance_sens,'r')
hold on
line([eee,eee],[min(hull_distance_sens),max(hull_distance_sens)],'color','w')
text(1,1000,['Overlaped clusters \newline ',num2str(clust_overlap_sens),' %'])
xlabel('Cluster nr')
ylabel(' min distance between points in cluster in nm')
title('Minimal distance between points of clusters from both point clouds','color','m')

subplot(1,2,2)
grid on
hold on
hl=histogram(hull_distance_sens,80,'Facecolor','g','FaceAlpha',1);
hold on
line([0,0],[0,max(hl.Values)],'color','b','linewidth',2)
xlabel(' min distance between points in cluster in nm')
ylabel(' Number of clusters')
title('Histogram of minimal distance between points of clusters from both point clouds','color','m')

suptitle('Minimal distance distribution between points of nearest neighbor clusters from both samples. Sensitive Method') 

