
function TT=z_TF_full(TT)

e=find(TT(1,:)==0);
if isempty(e)
    TT=TT;
else
for jw=1:numel(e)
    tx=0;
    ty=0;
    tz=0;
    i=TT(15,e(jw));
    k=TT(16,e(jw));
    
    NN= [i-1,k
        i+1,k
        i,k+1
        i,k-1];
    mmm=0;
    for kw=1:4
        
        et=find(TT(15,:)==NN(kw,1)& TT(16,:)==NN(kw,2));
        if isempty(et)==0
        tx=tx+TT(10,et);
        ty=ty+TT(11,et);
        tz=tz+TT(12,et);
        mmm=mmm+1;
        end
    end
    tx=tx/mmm;
    ty=ty/mmm;
    tz=tz/mmm;
    TT(10,e(jw))=tx;
    TT(11,e(jw))=ty;
    TT(12,e(jw))=tz;
    TT(1,e(jw))=1;
    TT(5,e(jw))=1;
    TT(9,e(jw))=1;
end
end
end 