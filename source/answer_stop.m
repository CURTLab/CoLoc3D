


button = questdlg('Current calibration. Do you want to continue? ','STOP CALCULATION','Stop now','Continue','Continue');

switch button
    case 'Stop now'
       disp('Hold program')
         clear('alpf', 'anzahlp', 'ep1', 'ep2', 'i', 'k', 'ind' ,'PF' ,'PM', 'PMc' ,...
        'PMo','pos1' ,'POS1', 'pos2', 'POS2', 'tc',' Rc', 'Ro', 'to', 'v', 'we',...
        'wm', 'x1', 'x2' ,'y1','y2')
       try
       STOP
       catch
           clc
           disp('Program terminated')
       end
   case 'Continue'
       Answer_calibration_type;
       quit cancel;
end