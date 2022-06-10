function dat=z2frame(dat,zi,fri)
Nmax=max(dat(:,fri));
Nmin=min(dat(:,fri));
Zero=round((Nmax-Nmin)/2);
dat(:,fri)=(dat(:,zi)/10+Zero);
end