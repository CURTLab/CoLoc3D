     
  function [dataou,cni,cenxi,cenyi,cenzi,clgi]=z_cluster(dataro,alpha,THRESH,xi,yi,zi,lasti,fig)

 
    
    pdat=dataro(:,[xi,yi,zi]);
    N=size(pdat,1)  ;
    disp('Distance calculation: Please wait')
    tic
    [~,dminavg]=distmin_NN(pdat);
     avg_min_dist=dminavg;
    
    disp(' Main clusters filtration: (DBSCAN)')
    [cl,centroid]=DBSCAN_neu(pdat,avg_min_dist,alpha,3,1,N);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%% data extension %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    EX=cl;
    for kl=1:numel(cl)
        a=cl(kl);
        e=find(cl==a);
        
        if a>0
            b=centroid(a,:);
            EX(kl,2:4)=b;
            EX(kl,5)=numel(e);
        end
    end
        
 dataro(:,lasti+1:lasti+5)=EX(:,1:5); 
 cni=lasti+1;       %%%%%%%%% cluster nummer
 cenxi=lasti+2;      %%%%%centroid x
 cenyi=lasti+3;     %%%% centroid y
 cenzi=lasti+4;     %%%% centroid z
 clgi=lasti+5;      %%%% cluster large
 e=find(dataro(:,lasti+5)<=THRESH*max(dataro(:,lasti+5)));
 dataou=dataro;      
 dataou(e,:)=[];   
   
  if fig == 1
      plot_cluster;
  end
  end
    
    
    
  

