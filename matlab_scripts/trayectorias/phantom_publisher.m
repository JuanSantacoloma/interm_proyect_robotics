function [pub,msg] = phantom_publisher(name_robot)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    pub(1)= rospublisher(strcat(name_robot,'/joint1_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(2)= rospublisher(strcat(name_robot,'/joint2_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(3)= rospublisher(strcat(name_robot,'/joint3_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(4)= rospublisher(strcat(name_robot,'/joint4_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(5)= rospublisher(strcat(name_robot,'/gripper_position_controller/command'), ...
    'std_msgs/Float64MultiArray'); %Creación publicador

    for i=1:5
        msg(i) = rosmessage(pub(i)); %Creacion de mensaje
    end
end
