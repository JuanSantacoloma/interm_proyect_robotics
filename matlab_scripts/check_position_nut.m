function [move_done] = check_position_nut(a_nut)
   joint_states_phantom2 = rossubscriber('/phantom2/joint_states', ...
        'sensor_msgs/JointState'); %Creación de suscriptor al tópico
    pause(1)
    joint_states_phantom2_data = joint_states_phantom2.LatestMessage;
    joint_states_phantom2_data.Position;

    if (joint_states_phantom2_data.Position(1)^2-a_nut(1)^2)<=0.01 && (joint_states_phantom2_data.Position(2)^2-a_nut(2)^2)<=0.01 && (joint_states_phantom2_data.Position(3)^2 - a_nut(3)^2)<=0.01 && (joint_states_phantom2_data.Position(4)^2 - a_nut(4)^2)<=0.01
        move_done = true;
    else
        move_done = false;
    end
end
