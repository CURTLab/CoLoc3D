 function mse=mse_voll(PMB,PFIX)
% function calculate sum(min(distance(mobile points,fix points,))/N

L1=size(PMB,1);
L2=size(PFIX,1);
L=L1+L2;

Z=pdist2(PMB,PFIX);

f=(sum(min(Z'))) ;
mse=f/L;

end