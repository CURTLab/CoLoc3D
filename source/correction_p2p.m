
alfmin=0.6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SHG=[];
SHG(1:Nmax,1:4)=0;
k=0;
for i=1:size(I_Shift,1)
pmx= dataf(i,xi);
pmy= dataf(i,yi);

k=k+1;
SHx=0;
SHy=0;
SH=[];
j=i;

alf=I_Shift(j,12);
m=I_Shift(j,5);
 %%%%%%%%%%%%%%%%% sum of shift %%%%%%%%%%%%%%%%%
while alf > alfmin && I_Shift(j,5)< Nmax
     
      alf=I_Shift(j,12);
      if alf >= alfmin
        SHx=SHx+I_Shift(j,9);
        SHy=SHy+I_Shift(j,10);
        SH(m,1)=SHx;
        SH(m,2)=SHy;
        SH(m,3)=m;
%%%%%%%%%%%%%%%%%%%%%% ACCUMULATION %%%%%%%%%%%%%
        SHG(m,1)=SHG(m,1)+ SHx;
        SHG(m,2)=SHG(m,2)+ SHy;
        SHG(m,3)=k; 
        SHG(m,4)=m;
       end

        m=I_Shift(j,5);
        j=I_Shift(j,6);

end
%%%%%%%%%%%%%%%%%%%%%%% correction x and y %%%%%%%%%%%%%%%%%%%
  pmx= pmx+SHx;
  pmy= pmy+SHy;
  dataf(i,xi)=pmx;
  dataf(i,yi)=pmy;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END CORRECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Zero=round((Nmax-Nmin)/2);

un=find(SHG(:,3)==0);
SHG(un,3)=1;
for h=1:numel(un)
    if un(h)>1
SHG(un(h),4)=SHG(un(h)-1,4)+1;
    end
end
SHG(1:end-1,1)=SHG(1:end-1,1)./SHG(1:end-1,3);
SHG(1:end-1,2)=SHG(1:end-1,2)./SHG(1:end-1,3);
SHG(:,5)=(SHG(:,4)-Zero)*10;


clear('un')



