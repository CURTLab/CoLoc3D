

function dat=frame2z(dat,fri,zi,z_step)
Nmax=max(dat(:,fri));
Nmin=min(dat(:,fri));
Zero=round((Nmax-Nmin)/2);
dat(:,zi)=(dat(:,fri)-Zero)*z_step;
end