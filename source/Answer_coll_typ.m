



button = questdlg('Select collocation algorithm',...
    'Standard collocation','Sensitive collocation','Standard collocation','Standard collocation');
switch button
    case 'Standard collocation'
      z_intersection3D;
          
       Answer_coll_typ;   
          
    case 'Sensitive collocation'
     z_intersection3D_fast;
   Answer_coll_typ;
end
