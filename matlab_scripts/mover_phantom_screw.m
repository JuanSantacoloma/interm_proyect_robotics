function mover_phantom_screw(a)
%     % Longitudes
%     l1 = (137-0)/100;
%     l2 = 105/100;
%     l3 = 105/100;
%     l4 = 95/100;
%     disp(a)
%     % Robot Phantom
%     q1=0; q2=0; q3=0; q4=0;
    % Conformacionn de los eslabones

%     phan(1) = Link('revolute', 'alpha',0,    'a',0,  'd',l1,'offset',-pi/2,'modified');
%     phan(2) = Link('revolute', 'alpha',-pi/2,'a',0,  'd', 0,'offset',-pi/2,'modified');
%     phan(3) = Link('revolute', 'alpha',0,    'a',l2, 'd', 0,'offset', 0,   'modified');
%     phan(4) = Link('revolute', 'alpha',0,    'a',l3, 'd', 0,'offset', 0,   'modified');
% 
%     phantom = SerialLink(phan,'name','Phatom X');
%     phantom.tool = troty(90,'deg')*transl(0,0,l4);
%     figure(1)
%     q=[0,0,0,0];
%     phantom.plot(q,'workspace',[-1 3 -2 2 -2 6],'noa','view',[-20.35 27.86])

    waistPub = rospublisher('/phantom1/joint1_position_controller/command', ...
        'std_msgs/Float64'); %Creación del publicador
    waistMsg = rosmessage(waistPub); %Creación del mensaje

    shoulderPub = rospublisher('/phantom1/joint2_position_controller/command', ...
        'std_msgs/Float64'); %Creación del publicador
    shoulderMsg = rosmessage(shoulderPub); %Creación del mensaje


    elbowPub = rospublisher('/phantom1/joint3_position_controller/command', ...
        'std_msgs/Float64'); %Creación del publicador
    elbowMsg = rosmessage(elbowPub); %Creación del mensaje


    wristPub = rospublisher('/phantom1/joint4_position_controller/command', ...
        'std_msgs/Float64'); %Creación del publicador
    wristMsg = rosmessage(wristPub); %Creación del mensaje


    handPub = rospublisher('/phantom1/gripper_position_controller/command', ...
        'std_msgs/Float64MultiArray'); %Creación del publicador
    handMsg = rosmessage(handPub); %Creación del mensaje


%     if a(1)<150 && a(1)>-150
        waistMsg.Data = 0 + (a(1));  %Envío de datos a partir de Home con límite de los motores
%     end
%     if a(2)<150 && a(2)>-150
        shoulderMsg.Data = 0 + (a(2));
%     end
%     if a(3)<150 && a(3)>-150
        elbowMsg.Data = 0 + (a(3));
%     end
%     if a(4)<150 && a(4)>-150
        wristMsg.Data = 0 + (a(4));
%     end
%     if a(1)<150 && a(1)>-150
        handMsg.Data = [0.01,0.01];
%     ends

%     phantom.animate([ deg2rad(a(1)) deg2rad(a(2)) deg2rad(a(3)) deg2rad(a(4)) ])
    send(waistPub,waistMsg); %Envio
    send(shoulderPub,shoulderMsg); %Envio
    send(elbowPub,elbowMsg); %Envio
    send(wristPub,wristMsg); %Envio
    send(handPub,handMsg); %Envio

    pause(2)
end