
function plot_grid(grid_size,xg,yg)
for i=1:grid_size
line ([xg(1),xg(end)],[yg(i+1),yg(i+1)])
line ([xg(i+1),xg(i+1)],[yg(1),yg(end)])
end
end