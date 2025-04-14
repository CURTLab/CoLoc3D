kontrola_sensiiv;
hull_distance_sens=cid2centr(:,6); %%%% 6 points 5 centroid
MM=size(hull_distance_sens,1);                                %M2H;
hull_distance_sens=sort(hull_distance_sens,'asc');
eee=find(hull_distance_sens<=0.05,1,'last');
if isempty(eee)==1
    eee=0;
end
mm=(eee);
clust_overlap_sens=round((mm/MM)*100,2);

    if isempty(coloc)==0
       % averClusterSize = mean(coloc(:,6));
        averClusterSize = round(sum(coloc(:,6))/size(coloc,1),1);
    else
    averClusterSize = 0;
    end

scrsz = get(0,'ScreenSize');
figure
whitebg('w')
grid on

set(gcf,'InnerPosition',[scrsz(1)+200,scrsz(2)+110, scrsz(3)*0.8,scrsz(4)*0.65]);

subplot(1,2,1)
grid on
hold on
bar(hull_distance_sens,'r')
hold on
line([eee,eee],[min(hull_distance_sens),max(hull_distance_sens)],'color','b')
text(1,0.5*max(hull_distance_sens),['Overlaped clusters of sample2\newline cluster ',num2str(eee),' /',num2str(MM),'=',num2str(clust_overlap_sens),' % \newline' ...
    'Mean cluster size = ',num2str(averClusterSize),' points'])
xlabel(['Cluster nr.  Clustering radius ',num2str(RRR),' nm'])
ylabel(' min distance between points in cluster in nm')
title('\rm Min. (points based) distance  between clusters of sample2 vs sample1','color','b')

subplot(1,2,2)
grid on
hold on
hl=histogram(hull_distance_sens,40,'Facecolor','g','FaceAlpha',1);
hold on
line([0,0],[0,max(hl.Values)],'color','b','linewidth',2)
xlabel(' min distance between points in cluster in nm')
ylabel(' Number of clusters')
title('\rm Hist. of min. distance between points of clusters of sample2 vs sample1','color','b')

suptitle(['\fontsize{13} Minimum distance distribution between cluster-points of Sample2 vs Sample1 (fix). {\bf Sensitive Method}'...
  '\newline {\bf Sample1 (fix)} ',exname1,', {\bf Sample2 (mobil)} ',exname2,  '\newline {\bf Volumetric:} average IoU of collocated clusters ',num2str(round(Qf*100,2)),' %  {\bf Quantitative:} number of collocated points to all points S2 =',num2str(round(QNf*100,2)),' %']); 

