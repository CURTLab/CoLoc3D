function [RI,TI]=ipc_trans_cloud(PMM,PFF)
if size(PFF,2)==2
PFF(:,3)=0;
PMM(:,3)=0;
end

    
PFC=pointCloud(PFF);
PMC=pointCloud(PMM);
%PMC=pcdenoise(PMC);
%PFC=pcdenoise(PFC);
if size(PFF,1)>=3 && size(PMM,1)>=3
%tform = pcregrigid(PMC,PFC);
%
tform = pcregistericp(PMC,PFC);
    %tform.Rotation
 stop   
    RI=tform.Rotation(1:3,1:3);
    TI=tform.Translation(1,1:3)';
   %PNC = pctransform(PMC,tform) ; 
else
    %[RP,TP] = rigid_transform_3D(PM',PF');pos
    RI= [1 0 0
        0 1 0
        0 0 1];
    TI=[0,0,0]';
end

end
