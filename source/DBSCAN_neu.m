function  [cl,c_primar]=DBSCAN_neu(pos,avg_min_dist,alpha,NP,NPP,N)

%[cl,c_primar]=DBSCAN_neu(pos,avg_min_dist,alpha,NP,NPP,N)


% Function generated primary (main) cluster

% cl cluster number
% c_primar centroids
% 
% alpha coefficient for neighborhood radius(=1)
% NP number of neighbors (min 5)
% NPP neigbors number for neighbors (min 4)
% pos,  points in original order
% N Number of points 
 
%%%%%%%%%%%%%%%%%%%%%%% data init %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%disp('___________________________')
%disp('Primary cluster generation. Please wait a few minutes')
dim=size(pos,2);

NRAD=alpha*avg_min_dist ;                       %%% minimal raius of neighborhood
cl(1:N,1)=0;                                    % cluster
al(1:N,1)=0;                                    % analyse marker
C=0;                                  
%tic

%%%%%%%%%%%%%%%%%%%% primary cluster finding %%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %kontr=round(0.1*N);                                    % current cluster number
 %jab=1;
 
for i=1:N
    
   %%%%%%%%%%%%%% display step %%%%%%%%%%%%%
    %if i==kontr*jab
    %    disp(['Done ',num2str(100*kontr*jab/N),'%']);
    %    jab=jab+1;
    %end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    if cl(i)==0
       al(i)=1; 
       temdis=pdist2(pos(i,:),pos);
       temdis(1,i)=1e+10;
       apn=find(temdis <= NRAD);
      
          if (numel(apn)>=NP) && (max(cl(apn))==0)
              C=C+1;
              cl(i)=C;
               
          
             
             e=100000000;
             while isempty(e)==0 
             e = find(apn>0,1,'first');
              
                if isempty(e)==0
                   j=apn(e);
                   apn(e)=0;
                   
                   if cl(j)==0 
                   cl(j)=C;
                   al(j)=1;
                   
                   
                   temdis_2=pdist2(pos(j,:),pos);
                   temdis_2(1,j)=1e+10;
                   epn=find(temdis_2<=NRAD);
                   
                       if numel(epn)>=NPP
                       apn=union(apn,epn);
                       end
                       
                   end    
                end
              end
          end
    end


end

%toc

%%%%%%%%%%%%%%%%%% end cluster finding %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% centroids %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=max(cl);

c_primar(1:L,dim)=0;
for kl=1:L
es=find(cl==kl);
if numel(es)==1
    c_primar(kl,:)=pos(es,:);
else
    c_primar(kl,:)=mean(pos(es,:));
end
end

end

