

pos =dataro(:,[xi,yi,zi]);
c_prim=centroid;

scrsz = get(0,'ScreenSize');
figure ('OuterPosition', [scrsz(3)/4.7 scrsz(4)/10 scrsz(4)/0.8 scrsz(4)/1.25]) ;
whitebg('k');

N=numel(pos(:,1));
clustm=min(cl);
if clustm==0
    clustm=1;
end
clustM=max(cl);
plot(pos(:,1),pos(:,2),'ob','Markersize',1.5,'markerfacecolor','b'); 
hold on
for i=clustm:clustM
        en=find(cl==i);
        xcl=pos(en,1);
        ycl=pos(en,2);
        zcl=pos(en,3);
        plotbox2(xcl,ycl,'g');
        hold on
        plot(xcl,ycl,'or','Markersize',1,'markerfacecolor','r'); 
        hold on
end     
hold on
plot(dataou(:,xi),dataou(:,yi),'ow','markerfacecolor','w','markersize',4)
plot(c_prim(:,1),c_prim(:,2),'or','markerfacecolor','r','markersize',4)

xlim([min(pos(:,1)),max(pos(:,1))])
ylim([min(pos(:,2)),max(pos(:,2))])
%axis image

title([ 'Primary cluster and centroids  '])    
clear('pos')


suptitle(['Primary clluster: white - points in cluster, blue - points outside cluster, red - centroids '])

clear('scrsz','c_prim','cl','pos','clustm','clustM','pos1','pos2','en', 'i' ,'xcl' ,'ycl')
