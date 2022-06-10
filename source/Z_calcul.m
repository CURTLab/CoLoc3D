
function Z=Z_calcul(pos)

 N=length(pos(:,1));
 %tic
 %disp('Distance graph calculation: Please wait ')
  if N <= 15000
  Z = linkage(pos,'complete');
  elseif N < 250000
  Z = linkage(pos,'ward','euclidean','savememory','on');
  else
      Z=0;
      disp('Big data. Reduction neccessary')
      stop
  end
  %toc
end