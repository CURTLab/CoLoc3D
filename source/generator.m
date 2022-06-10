

function enum= generator(size_1,size_2)


enum=[];
v=numel(enum);

while v < size_1
    nn=randi(size_2);
   if ismember(nn,enum)==0 
    enum=[enum,nn];
    v=numel(enum);  
   end
end
enum=sort(enum);
end