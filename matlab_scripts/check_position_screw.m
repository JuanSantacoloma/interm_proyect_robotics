function [move_done] = check_position_screw(a_screw)
    joint_states_phantom1 = rossubscriber('/phantom1/joint_states', ...
        'sensor_msgs/JointState'); %Creación de suscriptor al tópico
    pause(1)
    joint_states_phantom1_data = joint_states_phantom1.LatestMessage;
    joint_states_phantom1_data.Position;

    if (joint_states_phantom1_data.Position(1)^2-a_screw(1)^2)<=0.01 && (joint_states_phantom1_data.Position(2)^2-a_screw(2)^2)<=0.01 && (joint_states_phantom1_data.Position(3)^2 - a_screw(3)^2)<=0.01 && (joint_states_phantom1_data.Position(4)^2 - a_screw(4)^2)<=0.01
        move_done = true;
    else
        move_done = false;
    end
end