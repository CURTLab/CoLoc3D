
%%%%%%%%%%%%%%%%%% load roi.json %%%%%%%%%%%%%%%%%%%%
uiwait(msgbox('SELECT ROI.json DATA','modal'));
[pathname,dirname] = uigetfile('..\*.json');
fullpath = fullfile(dirname,pathname);
roidat = jsondecode(fileread(fullpath));

%%%%%%%%%%% equalization for frame with only 1 point
minPoint=3;
anzahlp=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% color 1 and 0 parameter 
offset1x= roidat.roi(1).offset.x ;
offset1y= roidat.roi(1).offset.y;                
height1= roidat.roi(1).size.height;
width1=roidat.roi(1).size.width;

offset2x= roidat.roi(2).offset.x ;
offset2y= roidat.roi(2).offset.y;                
height2= roidat.roi(2).size.height;
width2=roidat.roi(2).size.width;

color1minX= offset1x*pix;
color1maxX= (offset1x+width1-1)*pix;
color1minY= offset1y*pix;
color1maxY= (offset1y+height1-1)*pix;

color2minX= offset2x*pix;
color2maxX= (offset2x+width2-1)*pix;
color2minY= offset2y*pix;
color2maxY= (offset2y+height2-1)*pix;

pos=dat(:,[xi,yi]);
Nmax=max(dat(:,fri));
Nmin=min(dat(:,fri));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ROI selection
ep=find(pos(:,2)>=color1minY & pos(:,2)<=color1maxY );
datcolortem=dat(ep,:);
ep=find(datcolortem(:,xi)>=color1minX & datcolortem(:,xi)<=color1maxX );
datcolor1=datcolortem(ep,:);


ep=find(pos(:,2)>=color2minY & pos(:,2)<=color2maxY );
datcolortem=dat(ep,:);
ep=find(datcolortem(:,xi)>=color2minX & datcolortem(:,xi)<=color2maxX );
datcolor2=datcolortem(ep,:);
clear('datcolortem')

%%%%%%%%%%%%%%%%%%%%%% y axis equalizing
datcolor1(:,yi)= datcolor1(:,yi)-color1minY; %%%%%%%%%
datcolor2(:,yi)= datcolor2(:,yi)-color2minY;
datcolor1(:,xi)= datcolor1(:,xi)-color1minX; %%%%%%%%%
datcolor2(:,xi)= datcolor2(:,xi)-color2minX;
sizeMcolor1=[color1maxX-color1minX,color1maxY-color1minY];
sizeMcolor2=[color2maxX-color2minX,color2maxY-color2minY];


colorminX=min(color1minX,color2minX);
colormaxX=max(color1maxX,color2maxX);
colorminY=min(color1minY,color2minY);
colormaxY=max(color1maxY,color2maxY);

delta1=abs((color1minX-color2minX)/colorminX);
delta2=abs((color1maxX-color2maxX)/colormaxX);
delta3=abs((color1minY-color2minY)/colorminY);
delta4=abs((color1maxY-color2maxY)/colormaxY);
delta=min(max([delta1,delta2,delta3,delta4]),0.05);
delta=1+delta;
sizeMcolor1=[color1maxX-color1minX,color1maxY-color1minY];
sizeMcolor2=[color2maxX-color2minX,color2maxY-color2minY];
sizeMcolor1=sizeMcolor1*delta;
sizeMcolor2=sizeMcolor2*delta;

clear('delta1','delta2','delta3','delta4')

%%%%%%%%%%%%%%%%%%%%%%%%%%% z values test 

if z_empty==1
z_control_focus;
datcolor1(:,zi)=(datcolor1(:,fri)*z_step)-focus_ch0;
datcolor2(:,zi)=(datcolor2(:,fri)*z_step)-focus_ch1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%% z values test 



datcolor1o=datcolor1;
datcolor2o=datcolor2;


%%%%%%%%%%%%%%%%%%%%%%%%%% filter DBSCAN %%%%%%%%%%%%
Nmax1=max(datcolor1(:,fri));
Nmin1=min(datcolor1(:,fri));
Nmax2=max(datcolor2(:,fri));
Nmin2=min(datcolor2(:,fri));

Nmin=min(Nmin1,Nmin2);
Nmax=max(Nmax2,Nmax1);






datcolor1=refill_frame(datcolor1,fri,Nmin,Nmax);
datcolor2=refill_frame(datcolor2,fri,Nmin,Nmax);








close all
pos1=datcolor1(:,[xi,yi,zi]);
pos2=datcolor2(:,[xi,yi,zi]);
z_plot_test(pos1,pos2,'Original data')



%%%%%%%%%%%%%%%%%%%%%%%%% filtration NN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[POS1,ep] = filter_global(pos1,5,1);
datcolor1(ep,:)=[];
[POS2,ep] = filter_global(pos2,5,1);
datcolor2(ep,:)=[];
z_plot_test(POS1,POS2,'Data after filtration')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datcolor1=sortrows(datcolor1,fri,'asc');
datcolor2=sortrows(datcolor2,fri,'asc');




if anzahlp==1  
  
for i=Nmin+1:Nmax 
    ep=  find(datcolor1(:,fri)==i);
   
    if numel(ep) < minPoint
        disp(['Ch0 frame ',num2str(i),' only ',num2str(numel(ep)),' point'])
        em=find(datcolor1(:,fri)>=i-1 & dattcolor1(:,fri)<=i); 
        datneu1=datcolor1(em,:);
        datneu1(:,fri)=i;
       % datneu1(:,zi)=(datneu1(:,fri)*10)-focus_ch0;    
        datneu1=unique(datneu1,'rows');
        datcolor1=[datcolor1',datneu1']';
    end
 
   ep=  find(datcolor2(:,fri)==i);
    
  if numel(ep) < minPoint
       disp(['Ch1 frame ',num2str(i),' only ',num2str(numel(ep)),' point'])
        em=find(datcolor2(:,fri)>=i-1 & datcolor2(:,fri)<=i) ;
        datneu2=datcolor2(em,:);
        datneu2(:,fri)=i;
        %datneu2(:,zi)=(datneu2(:,fri)*10)-focus_ch1;    
        datneu2=unique(datneu2,'rows');
        datcolor2=[datcolor2',datneu2']';
  
  end
end
%plot_reduction;
end

datcolor1=sortrows(datcolor1,fri,'asc');
datcolor2=sortrows(datcolor2,fri,'asc');



%%%%%%%%%%%%%%%%%% Elimination of outliers %%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
[datcolor1g,cni,cenxi,cenyi,cenzi,clgi]=z_cluster(datcolor1,5,0.0100,xi,yi,zi,lasti,1);
[datcolor2g,cni,cenxi,cenyi,cenzi,clgi]=z_cluster(datcolor2,5,0.0100,xi,yi,zi,lasti,1);

datcolor1g=refill_frame(datcolor1g,fri,Nmin,Nmax);
datcolor2g=refill_frame(datcolor2g,fri,Nmin,Nmax);

datcolor1g=sortrows(datcolor1g,fri,'asc');
datcolor2g=sortrows(datcolor2g,fri,'asc');




%%%%%%%%%%%%%  
plot_beide;
%%%%%%%%%%%%%%%%%%%%%%%%%

clear('ep','u','pos1' ,'pos2' ,'i', 'pos','datcolortem','fullpath',...
    'datneu1','datneu2','em','POS1','POS2')
