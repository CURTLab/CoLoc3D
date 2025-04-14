


%%%%%%%%%%% List of tasks %%%%%%%%%%%%%%%%%%%%%%%%%%
lista={'CALIBRATION GRID based',...               %task 1 
'CALIBRATION INTERPOLATION based',...             %task 2 
'REGISTRY GRID based',...                         %task 3
'REGISTRY INTERPOLATION based',...                %task4
'COLLOCATION',...                              %task 5
'CURRENT STATISTIC ',...                   %task 6
'CLOSE All FIGURES ',...                          %task 7
'IMPORT DATA FROM EXCEL ',...                     %task 8
'DELETE OLD RESULTS ',...                     %task 9
'EXIT'};                                          %task 10              


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off
options.Interpreter = 'tex';
options.WindowStyle = 'modal';
figure(2000)
whitebg([0,70,90]/255) % background color
close figure 2000
%pause(0.1)
task=menu_w('COLLOCATION',lista);
clear('lista')
 