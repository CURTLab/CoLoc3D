function  [cl,c_primar]=DBSCAN_fast(pos,avg_min_dist,alpha,NP,NPP,N)

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


NRAD=alpha*avg_min_dist ;                       %%% minimal raius of neighborhood
cl(1:N,1)=0;   

cl = dbscan(pos,NRAD,NP);




%%%%%%%%%%%%%%%%%% end cluster finding %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% centroids %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=max(cl);
c_primar(1:L,3)=0;
for kl=1:L
es=find(cl==kl);
if numel(es)==1
    c_primar(kl,:)=pos(es,:);
else
    c_primar(kl,:)=mean(pos(es,:));
end
end

end

