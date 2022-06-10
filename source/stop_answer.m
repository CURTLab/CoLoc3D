





button = questdlg('Current correction. Do you want to continue? ','STOP CALCULATION','Pause now','Continue','Continue');

switch button
    case 'Pause now'
       disp('Hold program')
       %uiwait(msgbox('Pause End','Result','normal'))
        pause(10)
       stop_answer;
    case 'Continue'
       quit cancel;
end