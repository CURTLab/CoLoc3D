
function [R,t]=vector2RT(s)
R=[1,0,0
   0,1,0
   0,0,1];
t=s(1:3)';
end