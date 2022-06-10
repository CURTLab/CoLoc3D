
%%%%%%%%%%%%%%% first shift calculation and elimination 
[I_Shift1,datcolor1f]=Individ_shift(datcolor1g,fri,xi,yi,zi,sxi,Nmin,Nmax,0);
[I_Shift2,datcolor2f]=Individ_shift(datcolor2g,fri,xi,yi,zi,sxi,Nmin,Nmax,0);

%%%%%%%%%%%%%%% second shift calculation after elimination 
%[I_Shift1,datcolor1f]=Individ_shift(datcolor1f,fri,xi,yi,zi,sxi,Nmin,Nmax,0);
%[I_Shift2,datcolor2f]=Individ_shift(datcolor2f,fri,xi,yi,zi,sxi,Nmin,Nmax,0);


I_Shift=I_Shift1;
dataf=datcolor1f;
datao=datcolor1g;
correction_p2p;
plot_dryft(SHG,'Before correction Channel 0')

plot_correction;
suptitle('Channel0')
%plot_correction_3d;
suptitle('Channel0')

datcolor1f=dataf;       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SHG1=SHG;

%%%%%%%%%%%%%%%%%%% test figure
[I_Shift1test,datcolor1test]=Individ_shift(datcolor1f,fri,xi,yi,zi,sxi,Nmin,Nmax,0);
I_Shift=I_Shift1test;
dataf=datcolor1test;
datao=datcolor1;
correction_p2p;
plot_dryft(SHG,' After correction Channel 0')
clear('I_Shift1test','datcolor1test','dataf','SH','SHG','SHx','SHy','pmx','pmy')


I_Shift=I_Shift2;
datao=datcolor2g;
dataf=datcolor2f;
correction_p2p;
plot_dryft(SHG,'Before correction Channel 1')
plot_correction;
suptitle('Channel1')
%plot_correction_3d;
suptitle('Channel1')

datcolor2f=dataf;           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SHG2=SHG;

%%%%%%%%%%%%%%%%%%%%%%% test figure
[I_Shift1test,datcolor1test]=Individ_shift(datcolor2f,fri,xi,yi,zi,sxi,Nmin,Nmax,0);
I_Shift=I_Shift1test;
dataf=datcolor1test;
datao=datcolor1;
correction_p2p;
plot_dryft(SHG,' After correction Channel 1')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% elimination after correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PFL=datcolor1f(:,[xi,yi,zi]);
[~,ep] = filter_global(PFL,3,2);
datcolor1f(ep,:)=[];
datcolor1f=sortrows(datcolor1f,fri,'asc');


PFL=datcolor2f(:,[xi,yi,zi]);
[~,ep] = filter_global(PFL,3,2);
datcolor2f(ep,:)=[];
datcolor2f=sortrows(datcolor2f,fri,'asc');

%Answer_strong_filtration;
%if StrongF==1
%quality_strong_filtering;
%end

%%%%%%%%%%%%%% datcolorf after correction of dryft per chanel separaterly 




clear('I_Shift1test','datcolor1test','dataf','SH','SHG','SHx','SHy','pmx','pmy')
clear('dataf','SHG','SH','SHx','SHy','sg','PFL','ep',...
    'PM','PF','pmx','pmy','p','I_Shift','datao','j','k','i','h','m')

