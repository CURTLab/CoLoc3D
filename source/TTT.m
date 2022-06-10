


dkt=data1;
for iu=1:Nmax
    a=(dkt(iu,fri)-Zero)*10;
    
    b=dkt(iu,zi);
    if a~=b
        stop
    end
end