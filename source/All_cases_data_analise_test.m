
clc
clear
close all
load('distan.mat');

D=table2array(Distance);
D=unique(D,'rows');
e0=find(D(:,3)<=0);
d_int=D(e0,3);
d_int=abs(d_int);
e0=find(D(:,3)>0);
d_nint=D(e0,3);
%s=max(d_nint);
%d_int(end+1,:)=s;

delta=10;



ve=0:delta:12800;

nrBins=1000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 whitebg('w');
 hs = histogram(d_nint,'BinEdges',ve,'Normalization','pdf','FaceColor',[.0  1.0 .0],'Edgecolor','none');
 hold on

 px=hs.BinEdges;
 delta=hs.BinWidth;
 py=hs.BinCounts;
 dat1=hs.Data;
 pynint=py/sum(py*delta);
 
 hs1 = histogram(d_int,'BinEdges',ve,'Normalization','pdf','FaceColor',[1.0  0.0 .0],'Edgecolor','none');
 px1=hs1.BinEdges;
 delta1=hs1.BinWidth;
 py1=hs1.BinCounts;
 dat2=hs1.Data;
 pyint=py1/sum(py1*delta);
 
 whitebg('w');
 close all
 figure
 bar(px(1:end-1),pynint,'Facecolor','g','EdgeColor','none')
 hold on 
  bar(px1(1:end-1),pyint,'Facecolor','r','EdgeColor','none','facealpha',0.51)
 xlim([-100,max(px)])
 
hold on
 [ke,xx]=ksdensity(d_nint,px1,'kernel','epanechnikov');
  %s1=max(ke);
  %s2=max(py1/sum(py1));
  %ke1=ke/s1;
  %ke1=ke1*s2;
  %ke1=ke1/sum(ke1);
  kenint=ke;
  e1=find(pynint>0,1,'first');
  kenint(1:e1-1)=0;
  plot(px,kenint(1:end),'-k')
  
 [ke,xx]=ksdensity(d_int,px,'kernel','epanechnikov');
  %s1=max(ke);
  %s2=max(py1/sum(py1));
  %ke2=ke/s1;
  %ke2=ke2*s2;
  %ke2=ke2/sum(ke2);
  keint=ke;
  plot(px,keint(1:end),'-b')
  legend('Histogram for non-collocalized cluster','Histogram for collocalized cluster',...
     'PDF for non-collocalized cluster','PDF for collocalized cluster')
  xlim([-200,max(px)])
 title('Histogram and empirical PDF based distance distributions')


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ppy=[];
  ppx=[];
  pr=0;
 for i=1:size(px,2)-1
        if pynint(i)>0 && pyint(i)>0
            pz=min(pynint(i),pyint(i));
            ppy=[ppy,pz];
            ppx=[ppx,px1(i)];
            pr=pr+pz*delta;
        end
 end  
  
 
 
 
 
 
 figure
 bar(px1(1:end-1),pynint,'Facecolor','g','EdgeColor','none')
 hold on 
 hold on 
  bar(px1(1:end-1),pyint,'Facecolor','r','EdgeColor','none','facealpha',0.51)
  bar(ppx,ppy,'Facecolor','k','EdgeColor','none','facealpha',0.5)
  legend('Histogram for non-collocalized cluster','Histogram for collocalized cluster','Possible misclassification of collocation')
  xlim([-200,max(px)])
  grid on
  title(['Histogram based distance distributions',...
      '\newline The probability of misclassification of collocations ',num2str(pr*100),' %'])
  
  figure
  a1=area(px,kenint);
  a1.FaceColor='g';
  a1.FaceAlpha=0.5;
  hold on
  a2=area(px,keint);
  a2.FaceColor='r';
  a2.FaceAlpha=0.5;
  hold on

  keppy=[];
  keppx=[];
  kepr=0;
 for i=1:size(px,2)
        if kenint(i)>0 && keint(i)>0
            pz=min(kenint(i),keint(i));
            keppy=[keppy,pz];
            keppx=[keppx,px1(i)];
            kepr=kepr+pz*delta;
        end
 end  
  a3=area(keppx,keppy);
  a3.FaceColor='k';
  a3.FaceAlpha=0.5;
  hold on
  legend('Empirical PDF for non-collocalized cluster','Empirical PDF for collocalized cluster','Possible misclassification of collocation')
   title(['Empirical PDF based distance distributions',...
  '\newline The probability of misclassification of collocations ',num2str(kepr*100),' %'])
  