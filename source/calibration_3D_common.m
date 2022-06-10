clear
close all
clc
abstand=0;
Data_Load;
Chanel_data_preparation;

correction_point2point;
abstand=0;
quality_check;

stop_answer;
abstand=0;
Answer_calibration_type;




clear('alpf', 'anzahlp', 'ep1', 'ep2', 'i', 'k', 'ind' ,'PF' ,'PM', 'PMc' ,...
    'PMo','pos1' ,'POS1', 'pos2', 'POS2', 'tc',' Rc', 'Ro', 'to', 'v', 'we',...
    'wm', 'x1', 'x2' ,'y1','y2')
