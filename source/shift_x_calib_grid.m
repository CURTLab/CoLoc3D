  a=sortrows(dat2,1,"ascend");
  b=sortrows(dat2N,1,"ascend");
xnn=a(:,xi2)-b(:,xi2);
xnn=-xnn;
znn=a(:,zi2);
mm = size(znn,1)
for kk=1:mm
    znn(kk,2)=round(znn(kk),0);
end
znu=unique(znn(:,2));
mm = size(znu,1)
for kk=1:mm
    ep=find(znn(:,2)==znu(kk,1))
    xnm=xnn(ep,1);
    znu(kk,3)=mean(xnm);
end
uu=znu(:,1);
ww=znu(:,3);
ww=ww/100;
plot(uu,ww,'.b')

[fitresult, ~] = createFit(uu, ww);
