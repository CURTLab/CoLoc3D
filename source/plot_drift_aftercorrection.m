

[I_Shift1test,datcolor1test]=Individ_shift(datcolor2f,fri,xi,yi,zi,sxi,Nmin,Nmax,0);
I_Shift=I_Shift1test;
dataf=datcolor1test;
datao=datcolor1;
correction_p2p;
plot_dryft(SHG,' After correction Channel 0')
clear('I_Shift1test','datcolor1test','dataf','SH','SHG','SHx','SHy','pmx','pmy')