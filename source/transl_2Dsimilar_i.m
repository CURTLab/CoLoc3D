function f=transl_2Dsimilar_i(s)
% function calculate sum(min(distance(fix points,mobile points))

global PM
global PF
PN=PM;

    PN(:,1)=PM(:,1)+s(1);
    PN(:,2)=PM(:,2)+s(2);
    
    Z=pdist2(PN,PF);

    f=1*(sum(min(Z'))) ;

end
