function Q = cinInv(r,t,z,b)
    tcp = [r t z b];
    l1 = 42+94;
    l2 = 107;
    l3 = 107;
    l4 = 100;
    pr = [l1 l2 l3 l4];
    %O = [0 0 1; 0 -1 0; 1 0 0]*eul2r(tcp(4:6));
    %Pw = P' - O*[0 0 pr(4)]';
    tcp(4)=-tcp(4);
    z = tcp(3) - pr(4)*sin(tcp(4))- pr(1);
    x = tcp(1) - pr(4)*cos(tcp(4));
    r = sqrt(z^2+x^2);

    Q(1) = tcp(2);
    Q(2) = -(pi/2 - atan2(z,x) - acos((r^2 + pr(2)^2 - pr(3)^2)/(2*pr(2)*r)));
    cq3 = (z^2 + x^2 - pr(2)^2 - pr(3)^2) / (2*pr(2)*pr(3));
    Q(3) = -acos(cq3);
    Q(4) = (tcp(4) - Q(2) - Q(3));
end