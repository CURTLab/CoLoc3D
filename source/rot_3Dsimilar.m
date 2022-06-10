function f=rot_3Dsimilar(u)
% function calculate sum(min(distance(fix points,mobile points))

global PM
global PF

PN=PM;
    %Rotation z  %%%% u winkel in radian
    r1=cos(u) ;              
    r2=sin(u);
    PN(:,1)=PM(:,1)*r1-PM(:,2)*r2 ;
    PN(:,2)=PM(:,1)*r2+PM(:,2)*r1 ;
    PN(:,3)=PM(:,3);
Z=pdist2(PN,PF);
f=1*(sum(min(Z'))) ;

end