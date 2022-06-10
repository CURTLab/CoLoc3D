
pozycja1=[0.05, 0.3,0.9,0.65];
pozycja2= [0.15, 0.05,0.7,0.15];

M1=max(klaster1(:,1));
scrsz = get(0,'ScreenSize');
figure(200)
whitebg('k')
set(gcf,'Position',[scrsz(1)+600,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);
subplot('position',pozycja1)
grid on
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.b','markersize',2)
hold on
%plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.r','markersize',2)
view(2)
axis image
hh=text(2*min(pos1(:,1)),4*min(pos1(:,2)), ['Cluster ',num2str(i),'/',num2str(M1)],'color','k');
xlim([min(pos1(:,1)),max(pos1(:,1))+1000])
subplot('position',pozycja2)
hold on
grid on
xlim([0,M2+1])
%ylim([0,110])
title('Cluster collocation size in %')

tic
for i=1:M1
%disp(['cluster ',num2str(i),'/',num2str(M2)])
%overlap=0;
eoo=find(klaster1(:,1)==i);
hullo=pos1(eoo,:);
if numel(eoo)>3
[C000,v00] = convhulln(hullo);
%poly2=hull2(C2,:);
%vol2=v2;
figure(200)
subplot('position',pozycja1)
grid on
plot3(hullo(:,1),hullo(:,2),hullo(:,3),'.b','markersize',3)
hold on
if exist('C000','var')==1
trisurf(C000,hullo(:,1),hullo(:,2),hullo(:,3),'FaceColor','b','FaceAlpha',0.4)
end
end
end
toc