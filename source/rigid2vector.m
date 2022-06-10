function v=rigid2vector(R,t)
s=R(:)';
s=[s,t'];
v=s';
end