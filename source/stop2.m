crea.Interpreter='tex';
crea.WindowStyle = 'modal';
crea.Default='Continue';
button = questdlg('\fontsize{12}Do you want to continue? ','STOP ','Stop','Continue',crea);

switch button
    case 'Stop'
       disp('Exiting program')
        START_CALIBRATION;
    case 'Continue'
        close all
        quit cancel;
end
