

function [R,t]=vectorTF2RT(v)

rs= sin(v(13));
rc= cos(v(13));
R=[rc ,-rs,0
   rs ,rc,0
   0,0,1];
t=v(10:12);
end