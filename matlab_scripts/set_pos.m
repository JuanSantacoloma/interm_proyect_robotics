function set_pos(publisher,msg,Q)
    %preparar el mensaje
    for i=1:4
        msg(i).Data=Q(i);
    end

    %Enviar el mensaje
    for i=1:4
        send(publisher(i),msg(i)) %Envio
        %pause(1)
    end

end
