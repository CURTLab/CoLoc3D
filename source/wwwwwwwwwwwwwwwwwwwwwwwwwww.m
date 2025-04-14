poinFixOverFast=[];
if isempty(coloc)==0
enn=size(coloc,1);
for lk=1:enn
ukk=find(cidx(:,1)==coloc(lk,1));
up=pos(ukk,:);
poinFixOverFast=[poinFixOverFast',up']';
end

figure
hold on
plot(poinFixOverFast(:,1),poinFixOverFast(:,2),'or','markersize',18)

if isempty(PCOL_2)==0
plot(PCOL_2(:,1),PCOL_2(:,2),'.k','markersize',10)
end



end