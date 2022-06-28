function [xi,yi,zi,ini,sxi,syi,szi,fri,lasti,colhead,dat]=E_data_extraction_index(colhead,dat)
%%%%%%%%%%%%%%%%%%%% column index recognition %%%%%%%%%%%%%%%%%%%%%%%
L=size(dat,1);
M=size(dat,2);
MC=size(colhead,2);

if M~=MC
    E_wrong_dat_info;
    clear
    stopp
end

if M<3
    E_wrong_dat_info;
    clc
    disp('Data must have at least 3 columns');
    stopp
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




t = strcmpi('x',colhead);
 xi=find(t>0);
 if isempty(xi)==1
    msgbox('"x" header could not be found') 
    stopp
 end
 %%%%%%%%%%%%%%%%%%%%%%
  t = strcmpi('y',colhead);
  yi=find(t>0);
  if isempty(yi)==1
    msgbox('"y" header could not be found') 
    stopp
  end
%%%%%%%%%%%%%%%%%%%%%%%%%
 t = strcmpi('z',colhead);
 zi=find(t>0);
 if isempty(zi)==1
    msgbox('"z" header could not be found') 
    stopp
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% default%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  t = strcmpi('intensity',colhead);
  ini=find(t>0); 
  if isempty(ini)==1
      hh=msgbox('"intensity" header could not be found. Intensity will be default generated');
      u=normrnd(7100,1050,[L,1]);
      u=max(u,400);
      colhead(:,end+1)={'intensity'};
      dat(:,end+1)=u;
      ini=size(colhead,2);
  end


  
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%t = strcmpi('PA',colhead);
 t = strcmpi('PAX',colhead);
 sxi=find(t>0);
  if isempty(sxi)==1
      hh=msgbox('"pa" header could not be found. The point xy-accuracy will be default generated');
      u=normrnd(44,8,[L,1]);
      u=max(u,5);
      colhead(:,end+1)={'PA'};
      dat(:,end+1)=u;
      sxi=size(colhead,2);
  end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 t = strcmpi('PAY',colhead);
 syi=find(t>0);
  if isempty(syi)==1
      hh=msgbox('"pay" header could not be found. The point xy-accuracy will be default generated');
      u=normrnd(44,8,[L,1]);
      u=max(u,5);
      colhead(:,end+1)={'PAY'};
      dat(:,end+1)=u;
      syi=size(colhead,2);
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 t = strcmpi('PAZ',colhead); 
 szi=find(t>0);
  if isempty(szi)==1
     hh= msgbox('"paz" header could not be found. The point z-accuracy will be default generated');
      u=normrnd(80,15,[L,1]);
      u=max(u,55.5);
      colhead(:,end+1)={'PAZ'};
      dat(:,end+1)=u;
      szi=size(colhead,2);
  end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  t = strcmpi('frame',colhead); 
  fri=find(t>0);
  if isempty(fri)==1
      hh=msgbox('"frame" header could not be found. The frame number will be generated');
      if L<=19990
      u= (1:1:L)';
      else
      u=randi(19990,[L,1]);
      end
      colhead(:,end+1)={'frame'};
      dat(:,end+1)=u;
      fri=size(colhead,2);
  end
  lasti=size(colhead,2);
 
end
