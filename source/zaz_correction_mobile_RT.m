


function PMN =zaz_correction_mobile_RT(R,T,PM)
%%%%%%%%%%%% first translation finally rotation
PT=PM;
if size(PM,2)>= 2
    PT=PM';
end
PTM=PT; %+T;  
PTM=R*PTM+T;
PMN=PTM';
end