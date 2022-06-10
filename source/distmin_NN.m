function [d,dmin_avg]=distmin_NN(pos)

N=size(pos,1);


d(1:N,1)=0;

if N<=15000
    disp('Min-dist calculation: direct distance calculation')
    a=pdist2(pos,pos);
    a=sort(a);
    d(:,1)=a(2,:)';
    dmin_avg=mean(d(:,1));
    clear('a')
elseif N<=100000
    disp('Min-dist calculation: loop distance calculation. please wait')
    for i=1:N
        a=pdist2(pos(i,:),pos);
        a(i)=1e+10;
        d(i,1)=min(a);
    end
    dmin_avg=mean(d(:,1));
    clear('a')
    
else
  disp('Min-dist calculation: big data: min distance estimation')
  [dmin_avg,~]=estimation_min_dist(pos) ;
  d=[];
end

end
