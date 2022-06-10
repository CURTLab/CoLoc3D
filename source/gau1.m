

function [p]=gau1(x,A,sx,xc)

% function calculate 1D gauss function

%A=1/(sx*sqrt(2*pi));
g=(x-xc).^2./(2*(sx.^2)) ;
p=A*exp(-g);

end