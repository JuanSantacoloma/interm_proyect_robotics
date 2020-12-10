%rosinit;
%% Creación del Publicador y tipo de mensaje 
[pub,msg] = phantom_publisher('/robot_2');
%% Creación del Suscriptor
sub=rossubscriber('/robot_2/joint_states');
qs=zeros(6,6);
%% Enviar un mensaje
Q=[0,pi/2,-pi/2,pi];
closegripper(pub,msg);
set_pos(pub,msg,Q);
wait_pos(Q,sub)
%La función ModInv realiza la cinematica inversa, las entradas son(en
%orden):r, theta, z, beta
%% Aproximación
Q=cinInv(100,0,200,pi/4);
set_pos(pub,msg,Q);
opengripper(pub,msg);
wait_pos(Q,sub)
qs(1,:)=get_st(sub)';
%% Recogida
Q=cinInv(120,0,50,pi/2);
set_pos(pub,msg,Q);
wait_pos(Q,sub)
%% Cerrar Gripper
closegripper(pub,msg);
qs(2,:)=get_st(sub)';
%% Elevación
Q=cinInv(120,0,120,pi/2);
set_pos(pub,msg,Q);
wait_pos(Q,sub)
qs(3,:)=get_st(sub)';
%% Acercamiento
%Q=ModInv(150,0,70,pi/4);
%set_pos(pub,msg,Q)
%pause(6);
%% 
Q=cinInv(150,pi/2,90,pi/4);
set_pos(pub,msg,Q)
wait_pos(Q,sub)
qs(4,:)=get_st(sub)';
%% Entrega
Q=cinInv(200,pi/2,70,0);
set_pos(pub,msg,Q)
wait_pos(Q,sub)
%% Abrir Gripper
opengripper(pub,msg);
pause(3);
qs(5,:)=get_st(sub)';
%% Retirarse
Q=cinInv(100,pi/2,200,pi/4);
set_pos(pub,msg,Q);
wait_pos(Q,sub)
%% 
Q=cinInv(100,0,200,pi/4);
set_pos(pub,msg,Q);
opengripper(pub,msg);
wait_pos(Q,sub)
qs(6,:)=get_st(sub)';
%% Gráfica
figure(1)
stairs(rad2deg([qs(:,1) qs(:,2) qs(:,3) qs(:,4)]))
legend('q1','q2','q3','q4')
title('parametros articulares')
xlabel('secuencia')
ylabel('angulo(grados)')
grid on
%% 
qgrip=[0 0 0 0 0 0];
for i=1:length(qs(:,5))
    if qs(i,5)<0.005
        qgrip(i)=0;
    else
        qgrip(i)=1;
    end
end

figure(2)
stairs(qgrip)
title('posición del gripper')
xlabel('secuencia')
ylim([-0.5 1.5])
%% Ejemplo usando función
xo=[270,0,70];
xf=[0,200,70];
picknplace(xo,xf,pub,sub,msg)

%% cerrar nodo ROS
%rosshutdown