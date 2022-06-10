function f=transl_2Dsimilar(s)
% function calculate sum(min(distance(fix points,mobile points))

global PMI
global PFI
n1=size(PMI,1);
n2=size(PFI,1);
PN=PMI;
    PN(:,1)=PMI(:,1)+s(1);
    PN(:,2)=PMI(:,2)+s(2);

Z=pdist2(PN,PFI);


f=1*(median(min(Z'))) ;

end
