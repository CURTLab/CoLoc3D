
function [posc]=gauss_test(PMN,frame,threshGaus,PZ)

global PF
global SIGMAF
for h=1:size(PMN,1)
    z=pdist2(PMN(h,:),PF);
    e=find(z==min(z),1,'first');
    x=PMN(h,1);
    y=PMN(h,2);
    xc=PF(e,1);
    
    yc=PF(e,2);
    A=1;
    e=find(SIGMAF(:,3)==frame);
    sx=SIGMAF(e,1)*5;
    sy=SIGMAF(e,2)*5;
    [~,p]=gau2(x,y,A,sx,sy,xc,yc);
    
    if p<threshGaus
       PMN(h,1)=-1000;
    end
end

e=find(PMN(:,1)==-1000);
PMN(e,:)=[];
posc=PMN;
posc(:,4)=frame;
posc(:,3)=PZ;




end