


            global PF
            global PM



 % PF fix point (points from next fix group data1)
 % PM mobile points from next frame mobile group data2

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if exist('shm','var')==0
     quality_check;
  end
%%%%%%%%%%%%%%%%%%%%%%%%% optimizer parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimset('Display','off','LargeScale','on','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','on','LargeScale','on','MaxIter',2000,'TolFun',1e-14,...
%'Algorithm','trust-region');

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% START Point fo OPTIMALIZATION %%%%%%%%%%%
    if abstand==1
        mdist0 = mdist0;
    end
 
     s0=[100,100,100];
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_3Dsimilar,s0,options);
       dia=sqrt(sum(s.^2));
       if dia > 1.0*mdist0      %mudist(4)
            ws=max(mdist0/dia,0.2);
            %as=(shm+sh(1:3))/2; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            s=(ws*s + shm)/2;
       end
        [Ro,to]=vector2RT(s);
         PMO=PM;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
         PNN=PMO;
         PNN(:,1)=PM(:,1)+s(1);
         PNN(:,2)=PM(:,2)+s(2);
         PNN(:,3)=PM(:,3)+s(3);
         PM=PNN;
         u0=0;
   u = fminunc(@rot_3Dsimilar,u0,options); 
         Ro=[cos(u), -sin(u),0
             sin(u),cos(u),0
             0,0,1];
         PM=PMO;
  
  %%%%%%%%%%%%%%%%%%% save result in TO %%%%%%%%%%%%%%%
   v=rigid2vector(Ro,to);
   winkel=rad2deg(asin(v(2)));       %%%%% row 13
   v=[v',winkel,ind,i,k]';
   TO=[TO,v];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
