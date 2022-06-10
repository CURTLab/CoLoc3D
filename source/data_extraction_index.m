function [xi,yi,zi,ini,sxi,syi,szi,fri,lasti]=data_extraction_index(colhead)
%%%%%%%%%%%%%%%%%%%% column index recognition %%%%%%%%%%%%%%%%%%%%%%%
 t = strcmpi('x',colhead);
 xi=find(t>0);
 t = strcmpi('y',colhead);
 yi=find(t>0);
 t = strcmpi('z',colhead);
 zi=find(t>0);
 t = strcmpi('intensity',colhead);
 ini=find(t>0);
 %%%%%%%%%%%%%%%%%%%%%%%%%%
  
 t = strcmpi('PA',colhead);
 sxi=find(t>0);
 if isempty(sxi)==1
 t = strcmpi('PAX',colhead);
 sxi=find(t>0);
 end
 t = strcmpi('PAY',colhead);
 syi=find(t>0);
 if isempty(syi)==1
 syi=sxi;
 end
 
 
 t = strcmpi('PAZ',colhead); 
 szi=find(t>0);
 t = strcmpi('frame',colhead); 
 fri=find(t>0);
 lasti=size(colhead,2);
end