%% Intermediate Project

%% Imagen analysis
[img_out, x_screw, y_screw, x_nut, y_nut] = vision();

%% ROS initiallization
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
qs=zeros(6,6);

% Definifiendo punto inicia y final Screw
xo_1=[x_screw,y_screw,10];
xf_1=get_point_place_screw(1);
% Definifiendo punto inicia y final Nut
xo_2=[x_nut,y_nut,10];
xf_2=transl(-350,0,0)*[get_point_place_nut(3) 1]';
xf_2=xf_2(1:3)';
% Enviando la orden screw
% picknplace(xo_1,xf_1,pub1,sub1,msg1,pi/2)
% Enviando la orden nut
picknplace(xo_2,xf_2,pub2,sub2,msg2,0)
