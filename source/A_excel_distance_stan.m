WY=[];
WY=hull_distance_stan;
WY(:,7)=M2;



DISTANCEStan = array2table(WY,...
 'VariableNames',["Active cluster Nr","Min. Dist. Centroids NN-Cluster ","Min. Dist. Points NN-Cluster",...
"PA Active Cluster","Passive cluster Nr","PA Passive Cluster","Number of cluster" ]);

 outfile=[dirname2,'COLOC-Standard-Distance.Statistic_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname2,'.xlsm'];
 writetable(DISTANCEStan,outfile)