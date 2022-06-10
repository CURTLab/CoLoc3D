function focuss=z_control_focus_0(dat,fri,z_step)

Nmax=max(dat(:,fri));
Nmin=min(dat(:,fri));
focuss=round((Nmax-Nmin)/2)*z_step;
end