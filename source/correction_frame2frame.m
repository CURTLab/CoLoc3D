rng('default')
clc
%%%%%%%%%%%% global variable for functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            global PFI
            global PMI
            
 % PF fix point (points from next fix group data1)
 % PM mobile points from next frame mobile group data2

 datcol=datcolor1;
 POS=datcol(:,[xi,yi,fri]);
 Nmin = min(POS(:,3));
 Nmax = max(POS(:,3));
  %%%%%%%%%%%%% colons vectors of rigid parameters %%%%%%%%%%%%%%%%%%%%%%%%%
  F_Shift=[];
%%%%%%%%%%%%%%%%%%%%%%%%% optimizer parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
%'Algorithm','trust-region');


for i=1:Nmax                          %%%%%%%%%%%%%%%%%% i is frame 
 
 
  e1=find(POS(:,3)==i-1);                % index of fix points (kumulative or single)
  e2=find(POS(:,3)==i);                   % index of mobile points

  PFI=POS(e2,1:2);                      % fix points
  PMI=POS(e1,1:2);                      % mobile points
   
  avg=min(pdist2(PFI,PMI));
  avg=mean(avg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  disp(['frame ',num2str(i)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start shift estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
     s0=[0,0];
    
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_2Dsimilar,s0,options);
       
       we=sqrt(s(1)^2+s(2)^2);
       if we > 5*max_limit_drift && i>1
           s(1)=F_Shift(i-1,3);
           s(2)=F_Shift(i-1,4);
       end
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  save in F_Shift
        F_Shift(i,1)=i-1;
        F_Shift(i,2)=i;
        F_Shift(i,3)=s(1);
        F_Shift(i,4)=s(2);
        F_Shift(i,5)=we;
        F_Shift(i,6)=avg;
        F_Shift(i,7)=(i-Zero)*10;


end
F_Shift1=F_Shift;
plot_frame2frame_dryft;
[sh_x,sh_y,~]=spline_shift(F_Shift,Nmax,Zero); 

%%%%%%%%%%%%%%%%%%%%%%%% correction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  datcols=datcol;
for i= 1:Nmax
    e1=find(datcol(:,fri)<=i-1);
    datcol(e1,xi)=datcol(e1,xi)+ F_Shift(i,3);
    datcol(e1,yi)=datcol(e1,yi)+ F_Shift(i,4);
    %%%%%%%%%%%%%%%%%%%%% with spline %%%%%%%%%
    datcols(e1,xi)=datcols(e1,xi)+ sh_x(i);
    datcols(e1,yi)=datcols(e1,yi)+ sh_y(i);
end
datcolor1c=datcol;
datao=datcolor1;
dataf=datcol;
plot_correction;

clear('datao','dataf','datacol')

clc

            
 

 datcol=datcolor2;


 POS=datcol(:,[xi,yi,fri]);
 Nmin = min(POS(:,3));
 Nmax = max(POS(:,3));
 


 %%%%%%%%%%%%% colons vectors of rigid parameters %%%%%%%%%%%%%%%%%%%%%%%%%
  F_Shift=[];
%%%%%%%%%%%%%%%%%%%%%%%%% optimizer parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
%'Algorithm','trust-region');


for i=1:Nmax                          %%%%%%%%%%%%%%%%%% i is frame 
 
 
  e1=find(POS(:,3)==i-1);                % index of fix points (kumulative or single)
  e2=find(POS(:,3)==i);                   % index of mobile points

  PFI=POS(e2,1:2);                      % fix points
  PMI=POS(e1,1:2);                      % mobile points
   
  avg=min(pdist2(PFI,PMI));
  avg=mean(avg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   disp(['frame ',num2str(i)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start shift estimation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
     s0=[0,0];
    
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_2Dsimilar,s0,options);
       
       we=sqrt(s(1)^2+s(2)^2);
       if we > 5*max_limit_drift && i>1
           s(1)=F_Shift(i-1,3);
           s(2)=F_Shift(i-1,4);
       end
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  save in F_Shift
        F_Shift(i,1)=i-1;
        F_Shift(i,2)=i;
        F_Shift(i,3)=s(1);
        F_Shift(i,4)=s(2);
        F_Shift(i,5)=we;
        F_Shift(i,6)=avg;
        F_Shift(i,7)=(i-Zero)*10;


end

plot_frame2frame_dryft;
[sh_x,sh_y,~]=spline_shift(F_Shift,Nmax,Zero); 
F_Shift2=F_Shift;
%%%%%%%%%%%%%%%%%%%%%%%% correction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  datcols=datcol;
for i= 1:Nmax
    e1=find(datcol(:,fri)<=i-1);
    datcol(e1,xi)=datcol(e1,xi)+ F_Shift(i,3);
    datcol(e1,yi)=datcol(e1,yi)+ F_Shift(i,4);
    %%%%%%%%%%%%%%%%%%%%% with spline %%%%%%%%%
    datcols(e1,xi)=datcols(e1,xi)+ sh_x(i);
    datcols(e1,yi)=datcols(e1,yi)+ sh_y(i);
end
datcolor2c=datcol;
datao=datcolor2;
dataf=datcol;
plot_correction;clc


clear('datao','dataf','datcol','datcols','e1','e2','F_Shift','D')
