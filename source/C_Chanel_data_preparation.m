
%%%%%%%%%%%%%%%%%% losd roi.json %%%%%%%%%%%%%%%%%%%%
clear
clc
close all

Data_Load_1;
datcolor1=dat1;
datcolor1o=dat1;
Data_Load_2;
datcolor2=dat2;
datcolor2o=dat2;
xi=xi1;
yi=yi1;
zi=zi1;
fri=fri1;
lasti=lasti1;
sxi=sxi1;
szi=szi1;






%%%%%%%%%%%%%%%%%%%%%%%%%%%% equalization for frame with only 1 point
minPoint=3;
anzahlp=0;

%%%%%%%%%%%%%%%%%%%%% color 1 parameter 


color1minX= min(datcolor1(:,xi1));
color1maxX= max(datcolor1(:,xi1));
color1minY= min(datcolor1(:,yi1));
color1maxY= max(datcolor1(:,yi1));

color2minX= min(datcolor2(:,xi2));
color2maxX= max(datcolor2(:,xi2));
color2minY= min(datcolor2(:,yi2));
color2maxY= max(datcolor2(:,yi2));

%%%%%%%%%%%%%%%%%%%%%% y axis equalizing
%%datcolor1(:,yi)= datcolor1(:,yi)-color1minY; %%%%%%%%%
%datcolor2(:,yi)= datcolor2(:,yi)-color2minY;
%datcolor1(:,xi)= datcolor1(:,xi)-color1minX; %%%%%%%%%
%datcolor2(:,xi)= datcolor2(:,xi)-color2minX;


colorminX=min(color1minX,color2minX);
colormaxX=max(color1maxX,color2maxX);

colorminY=min(color1minY,color2minY);
colormaxY=max(color1maxY,color2maxY);

delta1=abs((color1minX-color2minX)/colorminX);
delta2=abs((color1maxX-color2maxX)/colormaxX);
delta3=abs((color1minY-color2minY)/colorminY);
delta4=abs((color1maxY-color2maxY)/colormaxY);
delta=max([delta1,delta2,delta3,delta4]);
delta=min(delta,0.15);
if delta<=0.1
delta=0.15;
end
delta=1+delta;
sizeMcolor1=[colormaxX-colorminX,colormaxY-colorminY];
sizeMcolor2=[colormaxX-colorminX,colormaxY-colorminY];
sizeMcolor1=sizeMcolor1*delta;
sizeMcolor2=sizeMcolor2*delta;


[z_empty1, z_step1]=Z_axis_test(datcolor1,zi,fri);
[z_empty2, z_step2]=Z_axis_test(datcolor2,zi,fri);

if z_empty1==1
    z_step=z_step1;
    z_control_focus;
    datcolor1(:,zi)=(datcolor1(:,fri)*z_step1)-focus_ch0;
end

if z_empty2==1
   z_step=z_step2;
   z_control_focus;
   datcolor2(:,zi)=(datcolor2(:,fri)*z_step2)-focus_ch1;
end

datcolor1o=datcolor1;
datcolor2o=datcolor2;





Nmax1=max(datcolor1(:,fri));
Nmin1=min(datcolor1(:,fri));
Nmax2=max(datcolor2(:,fri));
Nmin2=min(datcolor2(:,fri));

Nmin=max(Nmin1,Nmin2);
Nmax=min(Nmax2,Nmax1);

datcolor1=refill_frame(datcolor1,fri,Nmin,Nmax);
datcolor2=refill_frame(datcolor2,fri,Nmin,Nmax);





close all
pos1=datcolor1(:,[xi,yi,zi]);
pos2=datcolor2(:,[xi,yi,zi]);
z_plot_test(pos1,pos2,'Original data')

%%%%%%%%%%%%%%%%%%%%%%%%% filtration NN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[POS1,ep] = filter_global(pos1,5,1);
datcolor1(ep,:)=[];
disp(['Ch0: Deleted ',num2str(size(ep,1)),' points'])
[POS2,ep] = filter_global(pos2,5,1);
datcolor2(ep,:)=[];
disp(['Ch1: Deleted ',num2str(size(ep,1)),' points'])

z_plot_test(POS1,POS2,'Data after filtration')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datcolor1=sortrows(datcolor1,fri,'asc');
datcolor2=sortrows(datcolor2,fri,'asc');



datcolor1=refill_frame(datcolor1,fri,Nmin,Nmax);
datcolor2=refill_frame(datcolor2,fri,Nmin,Nmax);


if anzahlp==1  
for i=Nmin:Nmax 
    ep=  find(datcolor1(:,fri)==i);
   
    if numel(ep) < minPoint
        disp(['Ch0 frame ',num2str(i),' only ',num2str(numel(ep)),' point'])
        em=find(datcolor1(:,fri)>=i-1 & datcolor1(:,fri)<=i); 
        datneu1=datcolor1(em,:);
        datneu1(:,fri)=i;
        datneu1(:,zi)=(datneu1(:,fri)*10)-focus_ch0;    
        datneu1=unique(datneu1,'rows');
        datcolor1=[datcolor1',datneu1']';
    end
 
   ep=  find(datcolor2(:,fri)==i);
    
  if numel(ep) < minPoint
       disp(['Ch1 frame ',num2str(i),' only ',num2str(numel(ep)),' point'])
        em=find(datcolor2(:,fri)>=i-1 & datcolor2(:,fri)<=i) ;
        datneu2=datcolor2(em,:);
        datneu2(:,fri)=i;
        datneu2(:,zi)=(datneu2(:,fri)*10)-focus_ch1;    
        datneu2=unique(datneu2,'rows');
        datcolor2=[datcolor2',datneu2']';
  
  end
end
end

datcolor1=sortrows(datcolor1,fri,'asc');
datcolor2=sortrows(datcolor2,fri,'asc');



%%%%%%%%%%%%%%%%%% Elimination of outliers %%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                              

[datcolor1g,cni,cenxi,cenyi,cenzi,clgi]=z_cluster(datcolor1,5,0.0100,xi,yi,zi,lasti,1);
[datcolor2g,cni,cenxi,cenyi,cenzi,clgi]=z_cluster(datcolor2,5,0.0100,xi,yi,zi,lasti,1);


datcolor1=refill_frame(datcolor1,fri,Nmin,Nmax);
datcolor2=refill_frame(datcolor2,fri,Nmin,Nmax);


datcolor1g=sortrows(datcolor1g,fri,'asc');
datcolor2g=sortrows(datcolor2g,fri,'asc');




%%%%%%%%%%%%%  
plot_beide;
%%%%%%%%%%%%%%%%%%%%%%%%%

clear('ep','u','pos1' ,'pos2' ,'i', 'pos','datcolortem','fullpath',...
    'datneu1','datneu2','em','POS1','POS2')
