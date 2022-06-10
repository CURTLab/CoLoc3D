rng('default')
clc



%%%%%%%%%%%% global variable for functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            global PF
            global PM
            global SIGMAF
            global transit
 % PF fix point (points from next fix group data1)
 % PM mobile points from next frame mobile group data2
 % SIGMAF sigma of fix point (data 1)
 % transit   switch for rigid - 0 or transition only-1 for Newton gradient     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 transit=1;     %%%% 1 - transition only, 0 - rigid (rotation z and transition)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 datcolor1=datcolor1g;
 datcolor2=datcolor2f;
 
 
 datcolor1(:,lasti+1)=0;
 datcolor2(:,lasti+1)=0;
 POS1=datcolor1(:,[xi,yi,zi,fri]);
 POS2=datcolor2(:,[xi,yi,zi,fri]);
 SIGMA1=datcolor1(:,[sxi,sxi,sxi,fri]);
 SIGMA2=datcolor2(:,[sxi,sxi,sxi,fri]);
 
 framem1=min(POS1(:,4));
 framem2=min(POS2(:,4));
 frameM1=max(POS1(:,4));
 frameM2=max(POS2(:,4));
 
 low=max(framem1,framem2);
 up=min(frameM1,frameM2);
 if low==0
     POS1(:,4)=POS1(:,4)+1;
     POS2(:,4)=POS2(:,4)+1;
     low=low+1;
     up=up+1;
 end
 
%[POS1,TX1,TY1,datcolor1]=elimin_outlier(POS1,grenz_low,grenz_up,datcolor1,lasti,SIGMA1);
%[POS2,TX2,TY2,datcolor2]=elimin_outlier(POS2,grenz_low,grenz_up,datcolor2,lasti,SIGMA2);
DC=POS2(1,:);  

U=pdist2(POS1(:,1:2),POS2(:,1:2));
U=median(min(U));
u=max(U,500);
 

 %%%%%%%%%%%%% colons vectors of rigid parameters %%%%%%%%%%%%%%%%%%%%%%%%%

TO=[];
%%%%%%%%%%%%%%%%%%%%%%%%% optimizer parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','off','LargeScale','off','MaxIter',1000,'TolFun',1e-14,...
%'Algorithm','trust-region');

clc
disp('Parameter preparation. Please Wait')

PF=POS1(:,1:2);                      % fix points
PM=POS2(:,1:2); 
sfm0=[100,100];
    

%%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       sfm = fminunc(@transl_2Dsimilar_i,sfm0,options);


tresh=0.8;                          %%%% probability for point registration (Gauss PDF) %%%%%%%%%%%%%%%%%%%%%



if z_empty==0
    %wu1=unique(datcolor1(:,zi));
    %wu2=unique(datcolor2(:,zi));
    %L1=length(wu1);
    %L2=length(wu2);
    %L=min(L1,L2);
   % low=1;
   % up=L;
end    
    
    
    
for i=low:up                        %%%%%%%%%%%%%%%%%% i is frame 
 
  
  e1=find(POS1(:,4)==i)  ;              % index of fix points (kumulative or single)
  if isempty(e1)==1
      e1=et1;
  else
      et1=e1;
  end
  
  
  
  e2=find(POS2(:,4)==i)    ;            % index of mobile points
  if isempty(e2)==1
      e2=et2;
  else
      et2=e2;
  end
  
  
  PF=POS1(e1,1:2);                      % fix points
  PM=POS2(e2,1:2)  ;                    % mobile points
  SIGMAF=SIGMA1(e1,1:3);
  PZ=min(unique(POS2(e2,3)));
  if length(PZ)>1
  error('z-axis values are not uniquely assigned to a frame number')
  end
  disp(['frame ',num2str(i)])
 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START Point fo OPTIMALIZATION %%%%%%%%%%%
     
                          s0=[100,100];
    
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_2Dsimilar_i,s0,options);
      
       [Ro,to]=vector2RT_2d(s);
       we=sqrt(to(1)^2+to(2)^2);
       if we > 1.0*U
            ws=max(U/we,0.2);
            to=(ws*to + sfm')/2;
            %to=sfm';
       end
       
         PMO=PM;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
         PNN=PMO;
         PNN(:,1)=PM(:,1)+s(1);
         PNN(:,2)=PM(:,2)+s(2);
         PM=PNN;
         u0=0;
   u = fminunc(@rot_2Dsimilar,u0,options); 
         Ro=[cos(u), -sin(u)
             sin(u),cos(u)];
         PM=PMO;
       
       
       
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  save in TO
    v=rigid2vector(Ro,to);
    winkel=rad2deg(asin(v(2))); %%%%% row 7
    v=[v',winkel,i,PZ]';
    TO=[TO,v];
    
  
    
   
  %%%%%%%%%%%%%%%%%%% validation  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    
  PMN=zaz_correction_mobile_RT(Ro,to,PM);
  if  i==1
      DC=PMN;
      DC(:,3)=PZ;
      DC(:,4)=i;
  end
  %%%%%%%%%%%%%%%%%%%%%% end validation %%%%%%%%%%%%%%%%%%%
  
  %%%%%%%%%%%%%%%%% save tform %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%% plausibility test %%%%%%%%%%%%%%%
  [posc]=gauss_test(PMN,i,tresh,PZ);

  if i>1
  en=find(DC(:,4)==i-1);
  RET=DC(en,:);
  end
  
  if isempty(posc(:,1))==1
      posc=RET;
      posc(:,4)=i;
      disp('Warning: PM  new is empty')
      pause(0.5)
  end

DC=[DC',posc']';
end  


%%%%%%%%%%%%%%%%%%% output  %%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% aproximation with fourier 4  component  kurve 
 
 Aprox;
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%% save
 
  clear('button')
  tte=['interpolated_calibration_',num2str(day(datetime)),'_',num2str(month(datetime)),'_',exname,'.mat'];
  save(tte,'TO','exname','gfx', 'gfy', 'zz','xx','yy','gox','goy')
 
 
 
 