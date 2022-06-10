opts1.WindowStyle = 'normal';
 pause(0.05)
x = inputdlg({'The Z values are not given. Enter length  of Z axis data'},'Z',[1,30],{'2000'},opts1);
if isempty(x)==0
LZ = str2double(x{:});
%close
clear('x')
else
%close
clear('x')
%clear('grid_size')
quit cancel
end
