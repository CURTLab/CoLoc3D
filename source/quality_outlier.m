
%dt1=(datcolor1f);
%dt2=(datcolor2f);
%DSD=DS;
alp0=0.750;
clc
for i=1:Nmax                                    %frame nummer

    if gau1(DS(i,4),1,sigdist(4),mudist(4)) <  1
          
            et1=find(dt1(:,fri)==i);
            PF=dt1(et1,[xi,yi,zi]); 
            
            et2=find(dt2(:,fri)==i);
            PM=dt2(et2,[xi,yi,zi]);
            eweg=[];
            for j=1:numel(et2)
                 a=pdist2(PM(j,:),PF)';
                 en=find(a(:,1)==min(a),1,'first');
                 dista=a(en,:); 
                % g=gau1(dista,1,sigdist(4),mudist(4));
                 if dista >= mudist(4)+0.5*sigdist(4)
                     eweg=[eweg,et2(j)];
                     disp(['minDist: ',num2str(dista),' record to delete ',num2str(et2(j)),' '])
                 end
            end
            eweg=eweg';
            dt2(eweg,:)=[];
           % disp([num2str(numel(eweg)),' records deleted'])
            
     end
    
   
end   





        