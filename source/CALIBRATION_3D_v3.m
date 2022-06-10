   

button = questdlg('What type of data do you have in Matlab format?',...
    'calibration','Two separate data sets for channel 0 and channel 1','One common data for both channels (ROI.json necessary) ','One common data for both channels (ROI.json necessary) ');
switch button
    case 'Two separate data sets for channel 0 and channel 1'
     calibration_3D_separat;    
    case 'One common data for both channels (ROI.json necessary) '
     calibration_3D_common;      
        
end

