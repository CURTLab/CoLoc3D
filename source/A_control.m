
%%%%%%%%%%%%%%%%%% Data Loading and Info %%%%%%%%%%%%%%%

if task==1
    clc
   CALIBRATION_3D_v3;
    clear('btn','button','task')
elseif task==2
    clc
   CALIBRATION_INTERPOLATED;
    clear('btn','button','task')
elseif task==3
    clc
    REGISTRY_3D;
    clear('btn','button','task')
elseif task==4
    clc
    REGISTRY_INTERPOLATED;
    clear('btn','button','task')
elseif task == 5
    COLLOCATION_3D;
    clear('btn','button','task')
elseif task==6
    clear('btn','button','task')
    close all
elseif task==7
    clear('btn','button','task')
    user_stop
end

