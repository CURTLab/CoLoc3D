options.Interpreter = 'tex';
options.Default = 'New sample';

button = questdlg('\fontsize{12}Do you want to analyse the current sample or load a new sample',...
    'CLUST','Current Sample','New sample',options);
switch button
    case 'Current Sample'
      clc
      if exist('dat1','var')==0 || isempty(dat1)==1
       helpdlg('Sample do not exists','message')   
       START_CALIBRATION;
      end
      curr=1;
      %plot_original_data_12d(dat(:,xi),dat(:,yi),dat(:,zi),exname);
      clear('button')
      quit cancel;
              
     case 'New sample'
     clc
     curr=0;
     clear('button')
      quit cancel;
 
end