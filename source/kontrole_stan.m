

if isempty(colocat)==0
em=size(colocat,1);
    for il=1:em
        if colocat(il,5)>100;
            colocat(il,5)=(colocat(il,4)/(colocat(il,3)+colocat(il,6)))*100;
        end
    end
end
clear("em","il")