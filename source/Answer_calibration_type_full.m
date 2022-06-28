

button = questdlg('Select calibration algorithm',...
    'calibration','Frame-Based calibration','Point-Based calibration','Point-Based calibration');
switch button
    case 'Frame-Based calibration'
            answerneu;
            calibration;
            %tte=['calibration_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname,'.mat'];
            %save(tte,'TO','exname','xg1', 'xg2', 'yg1','yg2','grid_size','sizeMcolor1','sizeMcolor2')
        
    case 'Point-Based calibration'
           answerneu;
           %quality_check;
           calibration_p;
           %tte=['calibration_p_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname,'.mat'];
           %save(tte,'TO','exname','xg1', 'xg2', 'yg1','yg2','grid_size','sizeMcolor1','sizeMcolor2')
        
end

