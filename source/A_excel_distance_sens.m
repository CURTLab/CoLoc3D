WY=[];
WY=cid2centr(:,[1,5,6,7,8,9]);
WY(:,7)=M2;



DISTANCEFast = array2table(WY,...
 'VariableNames',["Active cluster Nr","Min. Dist. Centroids NN-Cluster ","Min. Dist. Points NN-Cluster",...
"PA Active Cluster","Passive cluster Nr","PA Passive Cluster","Number of cluster" ]);

 outfile=[dirname1,'COLOC-Sensitive-Distance.Statistic_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname2,'.xlsm'];
 writetable(DISTANCEFast,outfile)