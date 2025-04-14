
if exist('dat2','var')==1
collocation_both_methods;
else
crea.Interpreter='tex';
crea.WindowStyle = 'modal';
uiwait(msgbox(['\fontsize{14}Data not exists '],crea))
    START_CALIBRATION;
end