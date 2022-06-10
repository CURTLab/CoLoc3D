
button = questdlg('Current displacements field. Do you want to continue? ','STOP CALCULATION','Stop','Continue','Continue');

switch button
    case 'Stop'
       disp('Exiting program')
       stop_by_user;
       
    case 'Continue'
        
        quit cancel;
end



