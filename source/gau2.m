
function [AN,p]=gau2(x,y,A,sx,sy,xc,yc)

% function calculate 2D gauss function


g=(x-xc).^2./(2*sx.^2) +(y-yc).^2./(2*sy.^2);
p=A*exp(-g);
AN=mean(p);

end