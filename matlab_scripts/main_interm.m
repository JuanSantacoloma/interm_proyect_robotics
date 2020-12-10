%% Intermediate Project

%% Imagen analysis
[img_out, x_screw, y_screw, x_nut, y_nut] = vision();

%% Toolbox definition

% links
l1 = (137-0)/100;
l2 = 105/100;
l3 = 105/100;
l4 = 95/100;
% Robot
phan(1) = Link('revolute', 'alpha',0,    'a',0,  'd',l1,'offset',-pi/2,'modified');
phan(2) = Link('revolute', 'alpha',-pi/2,'a',0,  'd', 0,'offset',-pi/2,'modified');
phan(3) = Link('revolute', 'alpha',0,    'a',l2, 'd', 0,'offset', 0,   'modified');
phan(4) = Link('revolute', 'alpha',0,    'a',l3, 'd', 0,'offset', 0,   'modified');

phantom = SerialLink(phan,'name','Phatom X');
phantom.tool = troty(90,'deg')*transl(0,0,l4);


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
xo_1=[x_screw,y_screw,0.3500];
xf_1=get_point_place(1);
xf_1 = xf_1(1:3,4)'*100;
% Definifiendo punto inicia y final Nut
xf_2=transl(-3.50,0,0)*get_point_place(2);
xo_2=[x_nut,y_nut,0.3500];
xf_2 = xf_2(1:3,4)'*100;
% Enviando la orden screw
picknplace(xo_1,xf_1,pub1,sub1,msg1)
% Enviando la orden nut
picknplace(xo_2,xf_2,pub2,sub2,msg2)
%% Spawn objects gazebo
gazebo = ExampleHelperGazeboCommunicator;
ball = ExampleHelperGazeboModel("Ball")
sphereLink = addLink(ball,"sphere",1,"color",[0 0 1 1])
spawnModel(gazebo,ball,[8.5 0 1])
