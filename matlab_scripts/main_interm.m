%% Intermediate Project


%% Imagen analysis

%% Contruccion MTH 

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
mth_obj_screw = [rot_screw,[pos_x_screw;pos_y_screw;pos_z_screw];
                 [0,0,0,1]];
% Nut
mth_obj_nut = [rot_nut,[pos_x_nut;pos_y_nut;pos_z_nut];
                 [0,0,0,1]];
             
%% Move phantom
a_screw = invPhantom(mth_obj_screw);
a_nut = invPhantom(mth_obj_nut);

mover_phantom_1(a_screw)
mover_phantom_2(a_nut)