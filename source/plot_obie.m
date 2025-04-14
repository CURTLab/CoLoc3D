scrsz = get(0,'ScreenSize');
warning off
q1=size(pos1,1);
q2=size(pos2,1);
figure(20)
whitebg('w')
set(gcf,'Position',[scrsz(1)+300,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);
%subplot('position',pozycja1)
grid on
plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.c','markersize',2)
hold on
plot3(pos2(:,1),pos2(:,2),pos2(:,3),'.k','markersize',5,'markerfacecolor','r')
view(2)

%axis image
%xlim([min(pos1(:,1)),max(pos1(:,1))+1000])
%ylim([min(pos1(:,2)),max(pos1(:,2))+1000])


title(['\rm Original data. Sample 1 cyan ',num2str(q1),' points. Sample 2 black. ',num2str(q2),' points  \newline Sample 1 ',exname1,'  Sample 2 ',exname2])

xlabel('nm')
ylabel('nm')
aa=min(min(pos1(:,1)),min(pos2(:,1)));
bb=max(max(pos1(:,1)),max(pos2(:,1)));
cc=min(min(pos1(:,2)),min(pos2(:,2)));
dd=max(max(pos1(:,2)),max(pos2(:,2)));

grid on
ylim([cc,dd+1000])
xlim([aa,bb+1000])