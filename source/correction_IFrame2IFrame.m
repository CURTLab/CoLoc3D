 I_Shift=I_Shift1;
 datcol=datcolor1;
 
IF_Shift=[];
for i=1:Nmax
    e1=find(I_Shift(:,1)==i-1);
        IF_Shift(i,1)=i-1;
        IF_Shift(i,2)=i;
        IF_Shift(i,3)= median(I_Shift(e1,9));
        if abs(IF_Shift(i,3))>100
           IF_Shift(i,3)=IF_Shift(i-1,3);
        end
        IF_Shift(i,4)= median(I_Shift(e1,10));
        if abs(IF_Shift(i,4))>100
           IF_Shift(i,4)=IF_Shift(i-1,4);
        end
        IF_Shift(i,7)=(i-Zero)*10;
end
F_Shift=IF_Shift;
IF_Shift1=IF_Shift;
plot_frame2frame_dryft;

datcols=datcol;
for i= 1:Nmax
    e1=find(datcol(:,fri)<=i-1);
    datcol(e1,xi)=datcol(e1,xi)+ F_Shift(i,3);
    datcol(e1,yi)=datcol(e1,yi)+ F_Shift(i,4);
    %%%%%%%%%%%%%%%%%%%%% with spline %%%%%%%%%
    datcols(e1,xi)=datcols(e1,xi)+ sh_x(i);
    datcols(e1,yi)=datcols(e1,yi)+ sh_y(i);
end
datcolor1fc=datcol;
datao=datcolor1;
dataf=datcol;
plot_correction;
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear('I_Shift','datao','dataf','datcol','datcols','e1','e2','F_Shift','D','IF_Shift','F_Shift')
pause(0.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 I_Shift=I_Shift2;
 datcol=datcolor2;
 
IF_Shift=[];
for i=1:Nmax
    e1=find(I_Shift(:,1)==i-1);
        IF_Shift(i,1)=i-1;
        IF_Shift(i,2)=i;
        IF_Shift(i,3)= median(I_Shift(e1,9));
        if abs(IF_Shift(i,3))>100
           IF_Shift(i,3)=IF_Shift(i-1,3);
        end
        IF_Shift(i,4)= median(I_Shift(e1,10));
        if abs(IF_Shift(i,4))>100
           IF_Shift(i,4)=IF_Shift(i-1,4);
        end
        IF_Shift(i,7)=(i-Zero)*10;
end
F_Shift=IF_Shift;
IF_Shift2=IF_Shift;
plot_frame2frame_dryft;

datcols=datcol;
for i= 1:Nmax
    e1=find(datcol(:,fri)<=i-1);
    datcol(e1,xi)=datcol(e1,xi)+ F_Shift(i,3);
    datcol(e1,yi)=datcol(e1,yi)+ F_Shift(i,4);
    %%%%%%%%%%%%%%%%%%%%% with spline %%%%%%%%%
    datcols(e1,xi)=datcols(e1,xi)+ sh_x(i);
    datcols(e1,yi)=datcols(e1,yi)+ sh_y(i);
end
datcolor2fc=datcol;
datao=datcolor2;
dataf=datcol;
plot_correction;
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear('I_Shift','datao','dataf','datcol','datcols','e1','e2','F_Shift','D','IF_Shift','F_Shift')

