

 opts1.WindowStyle = 'normal';
 pause(0.05)
x = inputdlg({'Enter size of sector-grid'},'SECTORS',[1,30],{'3'},opts1);
if isempty(x)==0
grid_size = str2double(x{:});
%close
clear('x')
else
%close
clear('x')
clear('grid_size')
quit cancel
end





