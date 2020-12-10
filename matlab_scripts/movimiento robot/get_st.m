function states = get_st(sub)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
msg=sub.LatestMessage;
val=msg.Position;
states=zeros(6,0);
states(1)=val(3);
states(2)=val(4);
states(3)=val(5);
states(4)=val(6);
states(5)=val(1);
states(6)=val(2);
end