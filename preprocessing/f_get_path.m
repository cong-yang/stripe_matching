function [final]=f_get_path(OriShape)

[x,y]=size(OriShape);


%define the total number of white pixels and position
f=1;
for j=1:y
    for i=1:x
    if(OriShape(i,j)==1) 
        position(f,1)=j;
        position(f,2)=i;
        f=f+1;
    end;
    end;
end;

test=position;
final(1,:)=test(1,:);
test(1,:)=[];
for u=1:length(position)-1
clearvars vec; 
for uu=1:length(test)-1
  vec(uu,1)=test(uu,1);
  vec(uu,2)=test(uu,2);
  d=abs(final(u,1)-test(uu,1))+abs(final(u,2)-test(uu,2));
  vec(uu,3)=d;
end;
[minn, imin] = min(vec(:,3));
final(u+1,1)=vec(imin,1);
final(u+1,2)=vec(imin,2);
test(imin,:)=[];
end;

end