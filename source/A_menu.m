


%%%%%%%%%%% List of tasks %%%%%%%%%%%%%%%%%%%%%%%%%%
lista={'CALIBRATION GRID based',...               %task 1 
'CALIBRATION INTERPOLATION based',...             %task 2 
'REGISTRY GRID based',...                         %task 3
'REGISTRY INTERPOLATION based',...                %task4
'COLLOCATION',...                                 %task 5
'CLOSE All FIGURES ',...                          %task 6
'EXIT'};                                          %task 7               


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options.Interpreter = 'latex';
figure(2000)
whitebg([0,0,50]/255) % background color
close figure 2000
task=menu_w('SELECT TASK',lista);
clear('lista')
 