
function datcol=refill_frame(datcol,fri,Nmin,Nmax)



for i=Nmin+1:Nmax 
   
  ep=  find(datcol(:,fri)==i);
  if isempty(ep)==1
      disp(['frame ',num2str(i),' is empty'])
      pause(0.01)
      em=find(datcol(:,fri)==i-1);
      datneu1=datcol(em,:);
      datneu1(:,fri)=i;
      datneu1=unique(datneu1,'rows');
      datcol=[datcol',datneu1']';
  end
    
end