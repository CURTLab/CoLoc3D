
if isempty(colocat)==0
WY=[];
WY=colocat(:,[1,3,6,4,5]);
WY(:,6)=WY(:,4)./WY(:,2);
WY(:,7)=M2;
else
 WY(1,1:6)=0;
 WY(1,7)=M2;
end
STATIS = array2table(WY,...
 'VariableNames',["Active cluster Nr","Vol. Active Cluster","Vol. Passive Cluster",...
"Vol. Intersection","IoU in %",'Size of intersection',"Number of cluster"]);

 outfile=[dirname2,'COLOC-Standard.Statistic_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname2,'.xlsm'];
 writetable(STATIS,outfile)