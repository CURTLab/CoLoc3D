
function plotbox2(x,y,kolor)

xm=min(x);
ym=min(y);
xM=max(x);
yM=max(y);

if length(x)==1
xm=x-100;
xM=x+100;
end

if length(y)==1
ym=y-100;
yM=y+100;
end



dicke=1.0;
if kolor==0
col=[0.7,0.7,0.7];
else
col=kolor;
end


plot([xm,xM],[ym,ym],'-','linewidth',dicke,'color',col);
hold on
plot([xm,xm],[ym,yM],'-','linewidth',dicke,'color',col);
plot([xm,xM],[yM,yM],'-','linewidth',dicke,'color',col);
plot([xM,xM],[ym,yM],'-','linewidth',dicke,'color',col);


end

















