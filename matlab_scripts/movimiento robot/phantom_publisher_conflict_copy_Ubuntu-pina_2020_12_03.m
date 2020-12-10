function [pub,msg] = phantom_publisher(groupname)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    pub(1)= rospublisher(str2cat(groupname,'joint1_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(2)= rospublisher(str2cat(groupname,'joint2_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(3)= rospublisher(str2cat(groupname,'joint3_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(4)= rospublisher(str2cat(groupname,'joint4_position_controller/command'), ...
    'std_msgs/Float64'); %Creación publicador
    pub(5)= rospublisher(str2cat(groupname,'gripper_position_controller/command'), ...
    'std_msgs/Float64MultiArray'); %Creación publicador

    for i=1:5
        msg(i) = rosmessage(pub(i)); %Creacion de mensaje
    end
end
