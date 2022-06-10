
WY=[];
WY=coloc(:,[1,3,2,4,6,5]);
WY(:,4)=WY(:,4);%/100;
WY(:,7)=WY(:,2)./(WY(:,2)+WY(:,3));
WY(:,8)=M2;



STATISFast = array2table(WY,...
 'VariableNames',["Passive cluster Nr","Vol. Active Cluster","Vol. Passive Cluster",...
"IoU in %","Number of active points","Number of passive points",'Size of intersection',"Number of cluster"]);

 outfile=[dirname2,'COLOC-Sensitive.Statistic_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname2,'.xlsm'];
 writetable(STATISFast,outfile)