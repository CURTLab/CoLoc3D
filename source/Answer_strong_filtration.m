button = questdlg('Strong filtration ? ','STOP CALCULATION','Yes','No','No');

switch button
    case 'Yes'
       disp('Stron filtration')
       StrongF=1;
       
    case 'No'
       StrongF=0; 
       quit cancel;
end