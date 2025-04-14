
crea.Interpreter='tex';
crea.WindowStyle = 'modal';

if exist('DISTANCEStan','var')==1 && exist('DISTANCEFast','var')==0
    DISTANCE=DISTANCEStan;
elseif exist('DISTANCEStan','var')==0 && exist('DISTANCEFast','var')==1
     DISTANCE=DISTANCEFast;
elseif exist('DISTANCEStan','var')==1 && exist('DISTANCEFast','var')==1
     UPA=table2array(DISTANCEFast);
     UPB=table2array(DISTANCEFast);
     UPA=[UPA',UPB']';
DISTANCE= array2table(UPA,...
 'VariableNames',["Active cluster Nr","Min. Dist. Centroids NN-Cluster ","Min. Dist. Points NN-Cluster",...
"PA Active Cluster","Passive cluster Nr","PA Passive Cluster","Number of cluster" ]);
clear('UPA','UPB')

else
    uiwait(msgbox(['\fontsize{12} No co-location between current samples for radius ',num2str(RRR),' nm'],crea))
A_start;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(DISTANCE,1)<10   
    uiwait(msgbox(['\fontsize{12} Too few collocated points in current samples for radius ',num2str(RRR),' nm'],crea))
A_start;
end



