function picknplace(xi,xf,pub,sub,msg)
%PICKNPLACE genera la secuencia de recoger y dejar un objeto
%   x_i es la posición inicial respecto a la base, x_f es la posición final
%   grip es la apertura del gripper y pub,sub son los publicadores y
%   suscriptores del robot. La función devuelve los estados del gripper y 
%   de las articulaciones
%% Calculo de los puntos intermedios de la trayectoria
ri=sqrt(xi(1)^2+xi(2)^2);
thetai=atan2(xi(2),xi(1))
hi=xi(3);

%if ri<140
%    alpha_i=pi/2;
%else
%    alpha_i=0
%end
rf=sqrt(xf(1)^2+xf(2)^2);
thetaf=atan2(xf(2),xf(1))
hf=xf(3);
%Aproximación
q1=cinInv(ri-50,thetai,hi+20,pi/6);
%Recogida
q2=cinInv(ri,thetai,hi,0);
%Elevación
q3=cinInv(ri,thetai,hi+30,pi/6);
%Acercamiento
q4=cinInv(140,thetaf,hf+50,pi/6);
%Entrega
q5=cinInv(rf,thetaf,hf,0);
%Elevacion2
q6=cinInv(rf,thetaf,hf+50,pi/6);
%Retirada
q7=cinInv(100,0,200,pi/4);
%% Aproximación
opengripper(pub,msg);
set_pos(pub,msg,q1);
wait_pos(q1,sub);
qs(1,:)=get_st(sub)';
%% Recogida
set_pos(pub,msg,q2);
wait_pos(q2,sub);
%% Cerrar Gripper
closegripper(pub,msg);
pause(1)
qs(2,:)=get_st(sub)';
%% Elevación
set_pos(pub,msg,q3);
wait_pos(q3,sub)
qs(3,:)=get_st(sub)';
%% Acercamiento
set_pos(pub,msg,q4)
wait_pos(q4,sub)
qs(4,:)=get_st(sub)';
%% Entrega
set_pos(pub,msg,q5)
wait_pos(q5,sub)
opengripper(pub,msg);
pause(1);
qs(5,:)=get_st(sub)';
%% Elevacion2
set_pos(pub,msg,q6);
wait_pos(q6,sub);
%% Retirarse
set_pos(pub,msg,q7);
wait_pos(q7,sub);
%% 
figure(1)
stairs(rad2deg([qs(:,1) qs(:,2) qs(:,3) qs(:,4)]))
legend('q1','q2','q3','q4')
title('parametros articulares')
xlabel('secuencia')
ylabel('angulo(grados)')
grid on
end

