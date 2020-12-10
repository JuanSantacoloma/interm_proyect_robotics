%% Contruccion MTH 
% Run vision firts
% Rotando el sistema de referencia de la vision

% Screw
pos_x_screw = (r_screw*cos(t_screw));
pos_y_screw = (r_screw*sin(t_screw));
pos_z_screw = 0.3500;
rot_screw = rpy2tr(180, 2.25, -90.0, 'deg');
% Nut
pos_x_nut = (r_nut*cos(t_nut));
pos_y_nut = (r_nut*sin(t_nut));
pos_z_nut = 0.3500;
rot_nut = rpy2tr(180, 2.25, -90.0, 'deg');

%%
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
  
T_pick_screw = transl(pos_x_screw,pos_y_screw,pos_z_screw)*rot_screw;
T_pick_nut = transl(pos_x_nut,pos_y_nut,pos_z_nut)*rot_nut;

mth_obj_screw = T_pick_screw
mth_obj_nut = T_pick_nut
        
        
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

mover_phantom_screw(a_screw);
mover_phantom_nut(a_nut);
%% Move phantom
point_place = 1;
n=5;
move_done_screw = false;
move_done_nut = false;

%     Objetivos
%     T_pick_screw = get_point_pick_screw;
%T_pick_nut = get_point_pick_nut;

% T_place = get_point_place(point_place);
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