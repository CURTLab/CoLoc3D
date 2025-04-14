

if exist('cid2centr','var')==1 && isempty('cid2centr')==0

%%%%%%%%%%%%%% run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kontrola_sensiiv;

hull_distance_sens=cid2centr(:,5);

hull_distance_sens=sort(hull_distance_sens,'asc');
eee=find(hull_distance_sens<=0,1,'last');
if isempty(eee)==1
    eee=0;
end
clust_overlap_sens=round((eee/size(hull_distance_sens,1))*100,2);



scrsz = get(0,'ScreenSize');
figure
whitebg('w')
grid on

set(gcf,'Position',[scrsz(1)+200,scrsz(2)+100, scrsz(3)*0.8,scrsz(4)*0.63]);

subplot(1,2,1)
grid on
hold on
bar(hull_distance_sens,'r')
hold on
line([eee,eee],[min(hull_distance_sens),max(hull_distance_sens)],'color','b')
text(1,0.5*max(hull_distance_sens),['Overlaped clusters of sample 2\newline ',num2str(eee),' cluster=',num2str(clust_overlap_sens),' %'])
xlabel('Cluster nr')
ylabel(' min distance between centroids in nm')
title('\rm Minimum distance between the cluster centroids of sample2 vs sample1','color','k')

subplot(1,2,2)
grid on
hold on
hl=histogram(hull_distance_sens,50,'Facecolor','g','FaceAlpha',1);
hold on
line([0,0],[0,max(hl.Values)],'color','b','linewidth',2)
xlabel(' min distance between centroids in nm')
ylabel(' Number of clusters')
title('\rm Hist. of minimum distance between the cluster centroids of sample2 vs sample1','color','k')

suptitle(['Minimal distance distribution between centroids of nearest neighbor clusters from both samples. Sensitive Method'...
        '\newline {\bf Volumetric:} average IoU of collocated clusters ',num2str(round(Qf*100,2)),' %  {\bf Quantitative:} number of collocated points to all points S2 =',num2str(round(QNf*100,2)),' %']); 


else
    msgbox('Data do not exists')

    START_CALIBRATION;
end