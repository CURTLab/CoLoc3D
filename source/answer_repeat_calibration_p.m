button = questdlg([' MSE = ',num2str(msee),' nm'],...
    'MSE','SAVE','REPEAT','STOP','SAVE');
switch button
    case 'SAVE'
    
        if exist('exname','var')==0
            exname = exname1;
        end
        
        
     close all
     clear('button')
     tte=['calibration_p_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname,'.mat'];
     save(tte,'TO','exname','xg1', 'xg2', 'yg1','yg2','grid_size','sizeMcolor1','sizeMcolor2')
    
     clear('alpf', 'anzahlp', 'ep1', 'ep2', 'i', 'k', 'ind' ,'PF' ,'PM', 'PMc' ,...
    'PMo','pos1' ,'POS1', 'pos2', 'POS2', 'tc',' Rc', 'Ro', 'to', 'v', 'we',...
    'wm', 'x1', 'x2' ,'y1','y2')
    
     quit cancel     
     answer_stop
      
    case 'REPEAT'
    Answer_calibration_type;
    %answerneu;
    %quality_check;
    %calibration_p;
    %tte=['calibration_p_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname,'.mat'];
    %save(tte,'TO','exname','xg1', 'xg2', 'yg1','yg2','grid_size','sizeMcolor1','sizeMcolor2')
    
    clear('alpf', 'anzahlp', 'ep1', 'ep2', 'i', 'k', 'ind' ,'PF' ,'PM', 'PMc' ,...
    'PMo','pos1' ,'POS1', 'pos2', 'POS2', 'tc',' Rc', 'Ro', 'to', 'v', 'we',...
    'wm', 'x1', 'x2' ,'y1','y2')
    
    case 'STOP'
      quit cancel     
      answer_stop
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
     
end
