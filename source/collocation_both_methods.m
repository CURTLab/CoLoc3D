



if exist('PCOL_1','var')==1 && exist('PCOL_2','var')==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Average calculation
N2=size(dat2,1);
if isempty(PCOL_1)==0
Qp=sum(colocat(:,4))/(sum(colocat(:,3))+sum(colocat(:,6))-sum(colocat(:,4))); %%% Intersection over Union
%Qp=sum(colocat(:,4))/(sum(colocat(:,3))); %%% IoFull
QNp=size(PCOL_1,1)/N2;
else
Qp=0;
QNp=0;
end

if isempty(PCOL_2)==0
Qf=sum(min(coloc(:,3),coloc(:,2)))/(sum(coloc(:,2))+sum(coloc(:,3))) ; %%IoU
QNf=size(PCOL_2,1)/N2;
else
    Qf=0;
    QNf=0;
end

clc
disp(['volumetric average collocation standard method 1 =',num2str(Qp*100),' %'])
disp(['volumetric average collocation sensitive method 2 =',num2str(Qf*100),' %'])
disp(['quantitative average collocation standard method 1 = ',num2str(QNp*100),' %'])
disp(['quantitative average collocation sensitive method 2 =',num2str(QNf*100),' %'])    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
scrsz = get(0,'ScreenSize');
figure(300)
whitebg('k')
set(gcf,'Position',[scrsz(1)+200,scrsz(2)+70, scrsz(3)*0.6,scrsz(4)*0.83]);

plot3(pos1(:,1),pos1(:,2),pos1(:,3),'.b','markersize',3);
view(2)
grid on 
hold on
if isempty(PCOL_1)==0
plot3(PCOL_1(:,1),PCOL_1(:,2),PCOL_1(:,3),'or','markersize',8,'linewidth',2)
end
if isempty(PCOL_2)==0
plot3(PCOL_2(:,1),PCOL_2(:,2),PCOL_2(:,3),'.y','markersize',8)
end
legend('Passive cloud','coll Standard Method','coll Sensitive Method ')
axis image
title(['Comparison of collocated points from active cloud (METHOD 1-Standard and METHOD 2-Sensitive)',...
    '\newline METHOD-1:Volumetric average IoU= ',num2str(round(Qp*100,2)),' %',...
    ', Quantitative average collocation = ',num2str(round(QNp*100,2)),' %',...
    '\newline METHOD-2: Volumetric average IoU =',num2str(round(Qf*100,2)),' %',...
    ', Quantitative average collocation=',num2str(round(QNf*100,2)),' %'
    ],'color','g') 




if isempty(PCOL_2)==0
%histogram_hull_dist_sens_centr;
histogram_hull_dist_sens_point;
end

if isempty(PCOL_1)==0
%histogram_hull_dist_stan_centr;
histogram_hull_dist_stan_point;
end
end