


%%%%%%%%%%% List of tasks %%%%%%%%%%%%%%%%%%%%%%%%%%
lista={'CALIBRATION GRID based',...               %task 1 
'CALIBRATION INTERPOLATION based',...             %task 2 
'REGISTRY GRID based',...                         %task 3
'REGISTRY INTERPOLATION based',...                %task4
'COLLOCATION',...                              %task 5
'EXAMPLE STATISTIC: PDF ',...                   %task 6
'CLOSE All FIGURES ',...                          %task 7
'IMPORT DATA FROM EXCEL ',...                     %task 8
'EXIT'};                                          %task 9               


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options.Interpreter = 'latex';
figure(2000)
whitebg([0,0,50]/255) % background color
close figure 2000
task=menu_w('SELECT TASK',lista);
clear('lista')
 