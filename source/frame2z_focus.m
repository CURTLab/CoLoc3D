



function dat=frame2z_focus(dat,fri,zi,focus)
% for small number of frame frame_dim=10
frame_dim=1;

dat(:,zi)=(dat(:,fri)-focus)*frame_dim;


end