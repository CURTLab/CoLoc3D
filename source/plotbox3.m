
function plotbox3(x,y,z,kolor)

xm=min(x);
ym=min(y);
zm=min(z);
xM=max(x);
yM=max(y);
zM=max(z);

if length(x)==1
xm=x-100;
xM=x+100;
end

if length(y)==1
ym=y-100;
yM=y+100;
end

if length(z)==1
zm=z-100;
zM=z+100;
end

dicke=1;
if kolor==0
col=[0.7,0.7,0.7];
else
col=kolor;
end


plot3([xm,xM],[ym,ym],[zm,zm],'-','linewidth',dicke,'color',col);
hold on
plot3([xm,xm],[ym,yM],[zm,zm],'-','linewidth',dicke,'color',col);
plot3([xm,xM],[yM,yM],[zm,zm],'-','linewidth',dicke,'color',col);
plot3([xM,xM],[ym,yM],[zm,zm],'-','linewidth',dicke,'color',col);

plot3([xm,xM],[ym,ym],[zM,zM],'-','linewidth',dicke,'color',col);
hold on
plot3([xm,xm],[ym,yM],[zM,zM],'-','linewidth',dicke,'color',col);
plot3([xm,xM],[yM,yM],[zM,zM],'-','linewidth',dicke,'color',col);
plot3([xM,xM],[ym,yM],[zM,zM],'-','linewidth',dicke,'color',col);


plot3([xm,xm],[ym,ym],[zm,zM],'-','linewidth',dicke,'color',col);
hold on
plot3([xm,xm],[yM,yM],[zm,zM],'-','linewidth',dicke,'color',col);
plot3([xM,xM],[ym,ym],[zm,zM],'-','linewidth',dicke,'color',col);
plot3([xM,xM],[yM,yM],[zm,zM],'-','linewidth',dicke,'color',col);
end

















