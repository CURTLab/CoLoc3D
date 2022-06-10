
function [klaster,centroid,kcentroid,avg_min_dist,N]=cluster_preparation3D(pos,alpha)
    pdat=pos;
    if size(pdat,1)==3
        pdat=pdat';
    end
    N=size(pdat,1)  ;
      
    disp('Distance calculation: Please wait')

    %[~,dminavg]=distmin_NN(pdat);
    % avg_min_dist=dminavg;
    [avg_min_dist,~]=estimation_min_dist(pdat);
    
    
    tic
    disp(' Main-clusters calculation: (DBSCAN), please wait')
  
    [cl,centroid]=DBSCAN_neu(pdat,avg_min_dist,alpha,4,8,N);
    toc
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    kla=0;
     if kla==1
      
    disp('Standard-clusters calculation: (Hierarchical clustering), please wait')    
    rad=max(avg_min_dist*alpha*4,500);
    Zl=Z_calcul(pdat);
    kt = cluster(Zl,'cutoff',rad,'criterion','distance');
    klaster=[cl,kt];
    kcentroid(1:max(kt),1:3)=0;
    for i=1:max(kt)
        ee=find(kt==i);
        kcentroid(i,1)= mean(pdat(ee,1));
        kcentroid(i,2)= mean(pdat(ee,2));
        kcentroid(i,3)= mean(pdat(ee,3));
    end
    else
       klaster=cl; 
       klaster(:,2)=0;
       kcentroid=[];
    end
   
end