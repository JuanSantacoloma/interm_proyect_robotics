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

% Punto 1
% ab = transl(1.372,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
% Punto 2
% ab = transl(1.5920,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
% Punto 3
% ab = transl(2.0320,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
% Punto 4
% ab = transl(2.2500,0.4645,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
ab = transl(0.0,1.950,1.294)*rpy2tr(-165.696,0.0,180, 'deg');

% MTH de origen a base phantom 1
MTH_ogn_phantom1 = transl(0.08,0.119548,0.36373);
% MTH de origen a base phantom 2
MTH_ogn_phantom2 = transl(0.430453,0.119548,0.36373);

% MTH de origen a home
MTH_ogn_home= transl(0.0,0.0,4.42)*rpy2tr(0.0, 0.0, 1.0, 'deg');
% MTH de origen a base imagen screw
% MTH_ogn_screw = transl(0.430453,0.119548,0.36373);
% MTH de origen a base imagen nut
% MTH_ogn_nut = transl(0.430453,0.119548,0.36373);
  

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

%% Move phantom
point_place = 1;
n=5;
move_done_screw = false;
move_done_nut = false;

%     Objetivos
%     T_pick_screw = get_point_pick_screw;
%T_pick_nut = get_point_pick_nut;
T_pick_screw = transl(1.372,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
T_pick_nut = transl(0.2445,1.372,0.35)*rpy2tr(180, 2.25, -90.0, 'deg');

T_place = get_point_place(point_place);
% while point_place<=n
%     Flags
    move_done_screw = false;
    move_done_nut = false;       
    % Screw
    % Interpolation between home and Tqobj
    trayec_pick_screw = ctraj(MTH_ogn_home,T_pick_screw , n);
    trayec_pick_nut = ctraj(MTH_ogn_home,T_pick_nut , n);
    
%     trayec_assem = ctraj(MTH_ogn_home,T_pick_nut , n);
    
   % ab = transl(1.712,-1.0755,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %                  [0,0,0,1]];
    
%     Pick trayectory
    for trayec_count=1:n
        move_done_screw = false;
        move_done_nut = false;   
        mth_obj_screw = trayec_pick_screw(:,:,trayec_count)
        mth_obj_nut = trayec_pick_nut(:,:,trayec_count)

        % Screw
        % Cinematica Inversa
        [q1_screw, q2_screw, q3_screw, q4_screw] = invPhantom(mth_obj_screw);
        % Creando vector con la configuracion de la trayectoria
        a_screw = [q1_screw, q2_screw, q3_screw, q4_screw]

        % Nut
        % Cinematica Inversa
        [q1_nut, q2_nut, q3_nut, q4_nut] = invPhantom(mth_obj_nut);
        % Creando vector con la configuracion
        a_nut = [q1_nut, q2_nut, q3_nut, q4_nut];
        
        % Move phantom pick
        while not(move_done_screw) && not(move_done_nut)
            mover_phantom_screw(a_screw);
            mover_phantom_nut(a_nut);
            
            move_done_screw = check_position_screw(a_screw);
            move_done_nut = check_position_nut(a_nut);
            
        end
        
%     end
    
%  ************************************************************
    % Place trayectory
%     trayec_place = ctraj(MTH_ogn_home,T_place , n);
    
    % Place trayectory
%     for trayec_count=1:n
%         
%         mth_obj_screw = trayec_pick_screw(:,:,trayec_count);
%         mth_obj_nut = trayec_pick_nut(:,:,trayec_count);
% 
%         % Screw
%         % Cinematica Inversa
%         [q1_screw, q2_screw, q3_screw, q4_screw] = invPhantom(mth_obj_screw);
%         % Creando vector con la configuracion de la trayectoria
%         a_screw = [q1_screw, q2_screw, q3_screw, q4_screw];
% 
%         % Nut
%         % Cinematica Inversa
%         [q1_nut, q2_nut, q3_nut, q4_nut] = invPhantom(mth_obj_nut);
%         % Creando vector con la configuracion
%         a_nut = [q1_nut, q2_nut, q3_nut, q4_nut];
%         
%         % Move phantom pick
%         while move_done_screw && move_done_nut
%             mover_phantom_screw(a_screw)
%             mover_phantom_nut(a_nut)
%             move_done_screw = check_position_screw(a_screw);
%             move_done_nut = check_position_nut(a_nut);
%         end
%         
    end
    
    point_place = point_place +1
% end