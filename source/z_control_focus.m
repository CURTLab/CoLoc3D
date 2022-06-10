
button = questdlg('Do you have YAML type data to calculate z-focus for both channels 0 and 1 ',...
    'calibration','No','Yes','No');
switch button
    case 'Yes'
    %%%%%%%%%%%%%%%%%%%%%%%%% open YAML  file for Z-Focus preparation %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Data_Z_Focus_calculation;

   %%%%%%%%%%%%%%%%%%%%% result : focus_ch0 and focus_ch1 %%%%%%%%%%%%%%%%%%
    case 'No'
    focus_ch0=z_control_focus_0(datcolor1,fri,z_step);
    focus_ch1=z_control_focus_0(datcolor2,fri,z_step); 
        
end