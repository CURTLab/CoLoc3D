clc
global PM
global PF

dt1=(datcolor1g); %%%%%%%%%%%%% after filtration
dt2=(datcolor2f); %%%%%%%%%%%%% after correction

 %%%%%%%%% average min distance


DSq=[];
pt1=dt1(:,[xi,yi,zi]);
pt2=dt2(:,[xi,yi,zi]);

%uu=pdist2(pt1,pt2);
mdist0=100,%mean(min(uu)); 

for i=1:size(dt2,1)
        a=pdist2(pt2(i,:),pt1)';
        en=find(a(:,1)==min(a),1,'first');
        b=pt1(en,:);
        DSq(i,1:3)=b-pt2(i,:);
        %DSq(i,4)=sqrt(sum(DSq(i,1:3).^2));
        DSq(i,4)=a(en);  
        DSq(i,5)=gau1(a(en),1,200,100);
        DSq(i,7:9)=pt2(i,:);
        DSq(i,10:12)=b;  %%%%%%%%%%%%%%   dat1
        
        
end





sh=mean(DSq(:,1:4));
shsig=std(DSq(:,1:4))/2;
moment=0.5*mean(shsig(1:4));
%ef=find(DSq(:,5)<0.6);  



ef=find(DSq(:,4)>sh(4)+1*moment);
DSq(ef,6)=1;


dt1ou=dt1;
dt2ou=dt2;
pt2ou=dt2ou(:,[xi,yi,zi]);
DSqtem=DSq;
dt2outem=dt2ou;
%%%%%%%%%%%%%%%%%%%%%%%% outliers elimination
DSqtem(ef,:)=[];
dt2outem(ef,:)=[];
disp([num2str(numel(ef)),' outliers deleted'])

pt2outem=dt2outem(:,[xi,yi,zi]);

datcolor2fs=dt2outem;   %%%%%%%%%%%%%%%% eliminated outliers


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sh=mean(DSqtem(:,1:4))
shsig=std(DSqtem(:,1:4))/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


PM=pt2ou;
PF=pt1;

%%%%%%%%%%%%%%%%%%%%%%%%% optimizer parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimset('Display','off','LargeScale','on','MaxIter',1000,'TolFun',1e-14,...
'Algorithm','quasi-newton');
%options = optimset('Display','on','LargeScale','on','MaxIter',2000,'TolFun',1e-14,...
%'Algorithm','trust-region');

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% START Point fo OPTIMALIZATION %%%%%%%%%%%
   disp('optimalization')
    s0=[100,100,100];
    
  %%%%%%%%%%%%%%%  standard matlab minimization algorithm %%%%%%%%%%%%%%%%
       s = fminunc(@transl_3Dsimilar,s0,options);
       shm=s
       displacement_shm=sqrt(sum(shm.^2))  




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Please wait. Figure in preparation')
scrsz = get(0,'ScreenSize');

figure('OuterPosition', [scrsz(3)/6 scrsz(4)/11 scrsz(4)/0.8 scrsz(4)/1.35]) ;
whitebg('w')
subplot(1,2,1)
for i=1:size(DSq,1)
plot3(DSq(i,7),DSq(i,8),DSq(i,9),'or','MarkerSize',2)
hold on
grid on
plot3(DSq(i,10),DSq(i,11),DSq(i,12),'.b')
%legend('Start shift vector','End shift vector')
hold on
line([DSq(i,7),DSq(i,10)],[DSq(i,8),DSq(i,11)],[DSq(i,9),DSq(i,12)])
%pause(0.001)
end
title ('Displacement vectors (nearest neighbor) with outliers')



subplot(1,2,2)
for i=1:size(DSqtem,1)
plot3(DSqtem(i,7),DSqtem(i,8),DSqtem(i,9),'or','MarkerSize',2)
hold on
grid on
plot3(DSqtem(i,10),DSqtem(i,11),DSqtem(i,12),'.b')
hold on
line([DSqtem(i,7),DSqtem(i,10)],[DSqtem(i,8),DSqtem(i,11)],[DSqtem(i,9),DSqtem(i,12)])
%pause(0.001)
end
title ('Displacement vectors without outliers')
suptitle('Nearest Neighbor Displacement Vectors: start vector-red (chanel 0), end vector-blue (chanel 1)')