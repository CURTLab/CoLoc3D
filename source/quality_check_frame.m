


tic
global PF
global PM
DS=[];
disp('mu and sigma calculation. Please wait')

for i=1:Nmax
et1=find(dt1(:,fri)==i);
et2=find(dt2(:,fri)==i);
PM=dt2(et2,[xi,yi,zi]);
PF=dt1(et1,[xi,yi,zi]);

options = optimset('Display','off','LargeScale','on','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','on','LargeScale','on','MaxIter',2000,'TolFun',1e-14,...
%'Algorithm','trust-region');

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% START Point fo OPTIMALIZATION %%%%%%%%%%%
   
     s0=[100,100,100];
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_3Dsimilar,s0,options);
       s(3)=round(s(3),1);
       dd=sqrt(s(1)^2+s(2)^2+s(3)^2);
  DS(i,1:3)=s;
  DS(i,4)=dd;
  PMM=PM+s;
        fff=0;
        if fff==1
              figure
               plot3(PF(:,1),PF(:,2),PF(:,3),'sb')
               grid on
               hold on
               plot3(PM(:,1),PM(:,2),PM(:,3),'*r')
               hold on
               plot3(PMM(:,1),PMM(:,2),PMM(:,3),'ok') 
               % view(2)
        end
end

mudist=mean(DS)
sigdist=std(DS)/2
toc
