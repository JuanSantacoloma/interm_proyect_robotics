%% Intermediate Project


%% Imagen analysis

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

%% Inverse Kinematics


%% ROS initiallization
rosshutdown;
rosinit;

pause(10)

%% Contruccion MTH 
% ab = transl(1.622,-0.227,3.247)*rpy2tr(125.717, 80.210, 144.681, 'deg');
% ab = transl(0.259,1.618,3.247)*rpy2tr(-95.769, 9.068, 0.912, 'deg');
% ab = transl(0.0,1.329,1.524)*rpy2tr(-177.75, 0.0, 180, 'deg');
% ab = transl(1.329,0.0,1.524)*rpy2tr(180, 2.25, -90.0, 'deg');

% Punto de origen de la bandeja
% ab = transl(1.252,0.3645,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');

% Punto de origen de la bandeja
ab = transl(1.372,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');

% Screw
pos_x_screw = 0.0;
pos_y_screw = 0.0;
pos_z_screw = 4.0;
rot_screw = eye(3);
% Nut
pos_x_nut = 0.0;
pos_y_nut = 0.0;
pos_z_nut = 4.0;
rot_nut = eye(3);

% MTH objetivo

% Screw
% mth_obj_screw = [rot_screw,[pos_x_screw;pos_y_screw;pos_z_screw];
%                  [0,0,0,1]];
mth_obj_screw = ab;
% Nut

% mth_obj_nut = [rot_nut,[pos_x_nut;pos_y_nut;pos_z_nut];
%                  [0,0,0,1]];
mth_obj_nut = ab;
%% Move phantom
% Screw
[q1_screw, q2_screw, q3_screw, q4_screw] = invPhantom(mth_obj_screw);
a_screw = [q1_screw, q2_screw, q3_screw, q4_screw];
mover_phantom_1(a_screw)
% Nut
[q1_nut, q2_nut, q3_nut, q4_nut] = invPhantom(mth_obj_nut);
a_nut = [q1_nut, q2_nut, q3_nut, q4_nut];
mover_phantom_2(a_nut)