

options.Interpreter = 'tex';

pause(0.05)
x = inputdlg(['\fontsize{12}Enter radius. Avg Min Distance: ',num2str(amd1),' and ',num2str(amd2),' nm'],'ALP',[1,60],{num2str(amd)},options);
if isempty(x)==0
RRR= str2double(x);
if isnan(RRR)==1 
        hh=msgbox('Entry is not a number');
        pause(0.5);
        close(hh)
        clear('x','alp','hh')
        answer_alpha;
        quit cancel
end
clear('x')
else
clear('x')
Answer_coll_typ;
quit cancel
end