function wait_pos(Q_d,sub)
    e_p=0.004;
    t_s=0.5;
    for i=1:100
        pause(t_s);
        Q_a=get_st(sub);
        e=norm(Q_a(1:4)-Q_d,'fro');
        if e<e_p
            %disp('ha llegado a la posición')
            break
        end
    end
   pause(0.3)
end

