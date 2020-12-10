function closegripper(publisher,msg)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
      msg(5).Data=[0.01 0.01];
      send(publisher(5),msg(5)); %Envio
end

