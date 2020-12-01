function [q1,q2,q3,q4] = invPhantom(Tqobj)
    % Longitudes
    l1 = (137-0)/100;
    l2 = 105/100;
    l3 = 105/100;
    l4 = 95/100;
     % Matriz de tcp a q3
    tool_inv = [roty(0)', -roty(0)'*[0;0;l4];[0,0,0,1]];
    % Descomposicion en R y trasl
    Tq3 = Tqobj*tool_inv;
    [R,tras] = tr2rt(Tq3);
    % Descomposicion en [x,y,z, alpha]
    x = tras(1);
    y = tras(2);
    z = tras(3);
    alpha = tr2angvec(R);
    % Inversa
    % r
    r_pri_2 = ((z-l1)^2)+(x)^2+(y)^2;
    % q1
    q1 = atan2(y,x);
    % q3
    cq3 = ((r_pri_2)-l2^2-l3^2)/(2*l1*l2);
    sq3 = sqrt(1-cq3^2);
    q3 = atan2(sq3,cq3);
    % q2
    rho = atan2(l3*sq3,(l2 + l3*cq3));
    sigma = atan2(z-l1,sqrt((x)^2+(y)^2));
    q2 =pi/2-( rho + sigma);
    % q4
    q4 = alpha-q2-q3;
end