function move1(xi,yi,xf,yf,pub,sub)
rosshutdown;
rosinit;
pause(1)
%% Pick and place
% Creación del Publicador y tipo de mensaje 
[pub1,msg1] = phantom_publisher('/phantom1');
[pub2,msg2] = phantom_publisher('/phantom2');
% Creación del Suscriptor
sub1=rossubscriber('/phantom1/joint_states');
sub2=rossubscriber('/phantom2/joint_states');

picknplace([xi, yi, 10],[xf, yf, 0.7],pub,sub,msg,0)
end