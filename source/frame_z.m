

function FrameZ=frame_z(data,fri,zi)

FrameZ=[];
zz=0;
nmin=min(data(:,fri));
if nmin==0
    zz=1;
    data(:,fri)=data(:,fri)+1;
end
nmin=min(data(:,fri));
nmax=max(data(:,fri));    
    
for i=nmin:nmax
    e=find(data(:,fri)==i);
    a=data(e,zi);
    a=median(a);
    FrameZ(i,1)=i;
    FrameZ(i,2)=a;
end

   FrameZ(:,1)=FrameZ(:,1)-zz; 



end