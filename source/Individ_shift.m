
function [I_Shift,data]=Individ_shift(data,fri,xi,yi,zi,sxi,Nmin,Nmax,elimination)


%%%%%%%%%%%%%%%%%%%%%% point 2 nn-point shift %%%%%%%%%%%%%%%%%%%%%%%%%%

I_Shift=[];
for i=1:Nmax
    e1=find(data(:,fri)==i-1);
    e2=find(data(:,fri)==i);
    PM=data(e1,[xi,yi]);
    PF=data(e2,[xi,yi]);
    avg=min(pdist2(PF,PM));
    avg=median(avg);
    
      for j=1:numel(e1)
         I_Shift(e1(j),1)=i-1;
         I_Shift(e1(j),2)=e1(j);
         I_Shift(e1(j),3)=PM(j,1);
         I_Shift(e1(j),4)=PM(j,2);
         I_Shift(e1(j),5)=i;
    %%%%%%%%%%%%%%%%%%% point2point distance %%%%%%%%%%%%%%%%%%%%
         d=pdist2(PF,PM(j,:));
         em=find(d==min(d),1,'first');
         if isempty(em)==0
             d=d(em);
             I_Shift(e1(j),6)=e2(em);
             pf=PF(em,:);
        
         I_Shift(e1(j),7)=pf(1,1);
         I_Shift(e1(j),8)=pf(1,2);
         %%%%%%%%%%%%%%%%%%%%%%% one step shift %%%%%%%%%%%%%%%%%%%%%%%%%
         I_Shift(e1(j),9)= pf(1,1)-PM(j,1);
         I_Shift(e1(j),10)=pf(1,2)-PM(j,2);
         I_Shift(e1(j),11)=d;
         %%%%%%%%%%%%%%%%%%%%%%%%%%%% gauss %%%%%%%%%%%%%%%%%%%%
         sg=1.5*data(e2(em),sxi);
         [~,p]=gau2(PM(j,1),PM(j,2),1,sg,sg,pf(1,1),pf(1,2));
         I_Shift(e1(j),12)=max(p);
         I_Shift(e1(j),13)=avg;
         end
     end
end
%%%%%%%%%%%%%%%%%%%%%% END SHIFT CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% elimination of outlier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if elimination ==1
      %ee=find(I_Shift(:,11)>I_Shift(:,13));    %%%%% distance criterion
      ee=find(I_Shift(:,12)<0.5);              %%%%% probability criterion
      I_Shift(ee,:)=[];
      I_Shift=sortrows(I_Shift,1,'asc');
      data(ee,:)=[];
      data=refill_frame(data,fri,zi);
      data=sortrows(data,fri,'asc');
 end
end
