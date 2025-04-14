
%%%%%%%%%%%%%%%%%% Data Loading and Info %%%%%%%%%%%%%%%

if task==1
    clc
   CALIBRATION_3D_v3;
    clear('btn','button','task')
elseif task==2
    clc
   answer_interpolation; 
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
    collocation_statistic;
    All_cases_data_analise_test;
    clear('btn','button','task')
elseif task==7
    clear('btn','button','task')
    close all
elseif task==8
    clear('btn','button','task')
    try
    E_read;
    catch
        A_start;
    end
elseif task==9
    clear('btn','button','task')
    loschen_matfile;
elseif task==10
    clear('btn','button','task')
    close all;
   % putzen;
    clc;
    user_stop
end

