
function min_dist_hull=dist_hull(Vertic1,Vertic2)

if size(Vertic1,2)==3 && size(Vertic2,2)~=3
    Vertic2=Vertic2';
elseif size(Vertic1,2)~=3 && size(Vertic2,2)==3
    Vertic1=Vertic1';
end
AA = pdist2(Vertic2,Vertic1);
min_dist_hull=min(min(AA));

end