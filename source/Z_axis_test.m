
function [z_empty, z_step]=Z_axis_test(dat,zi,fri)
    clc
    sfrM=max(dat(:,fri));
    sfrm=min(dat(:,fri));
   
if min(dat(:,zi)== max(dat(:,zi)))
 
    disp('The Z values are not given. They will be calculated on the basis of the frame number.') 
    z_empty=1;
    z_axis_length;
    z_step = round(LZ/(sfrM-sfrm));
else
   z_empty=0;
   z_step = (max(dat(:,zi))-min(dat(:,zi)))/(sfrM-sfrm);
   disp('The Z values are given.')
   
end