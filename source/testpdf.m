


rys=1
%function [xhis,yhis,xpdf,ypdf,f]=testpdf(a,rys)

a=d_nint

sss=length(a);
[ccc,ddd]=hist(a,2000);
ccc=ccc/sss;
ccc=ccc/sum(ccc);

[f,xi] = ksdensity(a,ddd,'kernel','epanechnikov'); % normal''(default)'box''triangle''normal'

e=find(xi>=-10000);
xii=xi(e);
fii=f(e);


xi=xii;
f=fii;



s1=max(f);
s2=max(ccc);
f=f/s1;
f=f*s2;
e=find(ddd>=0);
dda=ddd(e);
cca=ccc(e);

xhis=dda;
yhis=cca;

f=f/sum(f);



xpdf=xi;
ypdf=f;

if rys==1
figure
whitebg('w')
h=bar(xhis,yhis);
coll=[230,230,230]/255;
%set(h,'FaceColor',coll,'EdgeColor',coll)
hold on
plot(xpdf,ypdf,'-r','LineWidth',2.4)
%plot(xia,fa)
title('Non-parametic PDF. Density')
end

%end
