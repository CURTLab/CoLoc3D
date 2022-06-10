

hull_distance=hull_distance_stan(:,2);
hull_distance=sort(hull_distance,'asc');
eee=find(hull_distance<=0,01,'last');
clust_overlap=round((eee/size(hull_distance,1))*100,2);



scrsz = get(0,'ScreenSize');
figure
whitebg('k')
grid on

set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.8,scrsz(4)*0.63]);

subplot(1,2,1)
grid on
hold on
bar(hull_distance,'r')
hold on
line([eee,eee],[min(hull_distance),max(hull_distance)],'color','w')
text(1,1000,['Overlaped clusters \newline ',num2str(clust_overlap),' %'])
xlabel('Cluster nr')
ylabel(' min distance between centroids in nm')
title('Minimal distance between centroids of clusters from both point clouds','color','m')

subplot(1,2,2)
grid on
hold on
hl=histogram(hull_distance,50,'Facecolor','g','FaceAlpha',1);
hold on
line([0,0],[0,max(hl.Values)],'color','b','linewidth',2)
xlabel(' min distance between centroids in nm')
ylabel(' Number of clusters')
title('Histogram of minimal distance between centroids of clusters from both point clouds','color','m')

suptitle('Minimal distance distribution between centroids of nearest neighbor clusters from both samples. Standard Method') 

