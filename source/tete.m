zzz=dat(:,zi);
%zm=abs(min(zzz));
%zzz=zzz+zm;
zzz=unique(round(zzz,2));
zzz=sort(zzz);
L=length(zzz);
for i=1:L
    ep=find(round(dat(:,zi),2)==zzz(i));
    dat(ep,fri)=i;
end