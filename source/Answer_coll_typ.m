

options.Interpreter = 'tex';
options.Default='Standard collocation';
button = questdlg('\fontsize{12} Select collocation algorithm',...
    'Standard collocation','Sensitive collocation','Stop','Standard collocation',options);
switch button
    case 'Standard collocation'
      z_intersection3D;
       Answer_coll_typ;   
          
    case 'Sensitive collocation'
     z_intersection3D_fast;
     Answer_coll_typ;
    case 'Stop'
     disp('Exiting program')
       START_CALIBRATION;

end
