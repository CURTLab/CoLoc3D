

function f=transl_3Dsimilar(s)
% function calculate sum(min(distance(fix points,mobile points))

global PM
global PF
PN=PM;

    
    PN(:,1)=PM(:,1)+s(1);
    PN(:,2)=PM(:,2)+s(2);
    PN(:,3)=PM(:,3)+s(3);
    
    pen= max(abs(PN(:,3)));
   if pen>1000
       pen=20*(pen-1000)^2;
   else
       pen=0;
   end
     
   
Z=pdist2(PN,PF)  ;


f=1*((sum(min(Z')))+ pen );

end
