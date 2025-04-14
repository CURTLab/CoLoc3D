
crea.Interpreter='tex';
crea.WindowStyle = 'modal';
crea.Default='Stop';
button = questdlg('\fontsize{12}You need one common data for both channels with two ROI (necessary ROI.json)? ','STOP ','Stop','Continue',crea);

switch button
    case 'Stop'
       disp('Exiting program')
        START_CALIBRATION;
    case 'Continue'
        close all
        quit cancel;
end
