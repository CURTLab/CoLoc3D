    
    function [POSF,ep] = filter_global(POS,alpha,typ)
    pdat=POS(:,1:3);
    N=size(pdat,1)  ;
    disp('Distance calculation: Please wait')
    tic
    [Dmin,dminavg]=distmin_NN(pdat);
    avg_min_dist=dminavg;
    
    
    
  
    if typ==1
    disp(' Main-clusters filtration: (DBSCAN)')
    [cl,~]=DBSCAN_neu(pdat,avg_min_dist,alpha,3,2,N);
    ep=find(cl==0);
    POS(ep,:)=[];
    elseif typ==2
    disp('Fast filtration: nearest neighbor (NN)')  
    ep=find(Dmin > alpha*avg_min_dist);    
    POS(ep,:)=[];
    end
    POSF=POS;
    end