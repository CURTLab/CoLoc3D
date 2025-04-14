clc

if isempty('coloc')==0
 Ncolon=size(coloc,1);
 eo=find(cid2centr(:,6)<=0.05);
 Ncid2cen=numel(eo);
 %pointliczba= round(sum(coloc(:,6))/Ncolon,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if Ncolon~=Ncid2cen
    for ll=1:Ncolon
     sm=coloc(ll,1);
     em=find(cid2centr(:,1)==sm,1,'first');
        if cid2centr(em,6)>0.05
            cid2centr(em,5)=-cid2centr(em,5);
            cid2centr(em,6)=-cid2centr(em,6);
        end
    end
 end
end

clear('Ncolon', 'em',"sm", "Ncid2cen","eo","ll")