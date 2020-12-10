function [img_out, x_screw, y_screw, x_nut, y_nut] = vision()
    im = imread("I8.jpeg"); % lectura de la imagen
%     imshow(im)

    g = im(:,:,3); % Se pasa la imagen a escala de gris
    %imshow(g)

    d = size(g); % Tamaño de la imagen

    % Umbralizacion
    for i = 1:d(1)
        for j = 1:d(2)
            if g(i,j) > 100
                t(i,j) = 0;
            else
                t(i,j) = 255;
            end
        end
    end
    %imshow(t)

    cl = imclose(t,strel('disk',30)); % Se rellan las regiones conectadas
    %imshow(cl)

    tr = bwareaopen(cl,600); % Se limpia la imagen de posible ruido
%     imshow(tr)
    rc = bwconncomp(tr);

    img_out = tr;
    
    Tornillos = 0;
    Tuercas = 0;
    pt = {};
    ptor = {};
    otor = {};

    cent = regionprops(rc,'Centroid');
    cir = regionprops(rc,"Circularity"); %0.8
    ejeM = regionprops(rc,"MajoraxisLength"); %150
    ori = regionprops(rc,'Orientation');
    
    
    for i = 1:rc.NumObjects
        pt{i,1} = cent(i,1).Centroid;       

        if cir(i,1).Circularity > 0.8
            Tuercas = Tuercas + 1;
            pt{i,2} = 'tuerca';
        elseif ejeM(i,1).MajorAxisLength > 100
            Tornillos = Tornillos + 1;
            otor{Tornillos,1} = ori(Tornillos,1).Orientation;
            pt{i,2} = 'tornillo';
        end
    end
%     ORGANIZACION DE LOS ELEMENTOS
    for i = 2:length(pt)
        while i ~= 1
            if pt{i,1}(2) < pt{i-1,1}(2)
                a = pt{i-1,1};
                b = pt{i-1,2};
                pt{i-1,1} = pt{i,1};
                pt{i-1,2} = pt{i,2};
                pt{i,1} = a;
                pt{i,2} = b;
            end
            i = i-1;
        end
    end
% Ubicacion de elementos en magnitud fisica
    esc = 200; % Escala de conversion (200 mm) 150
    x0 = -150; % Distancia entre el SC del primer robot y de la base sobre x.
    y0 = 60; % Distancia entre el SC del primer robot y de la base sobre y.
    % b = 200; % Distancia entre los dos robots sobre x.
    b = 0; % Distancia entre los dos robots sobre x.
%   
    x_nut = zeros(Tuercas);
    y_nut = zeros(Tuercas);
    screws = 1;
    x_screw = zeros(Tornillos);
    y_screw = zeros(Tornillos);
    nuts = 1;
    for i = 1:length(pt)
        x = esc/d(1)*pt{i,1}(1);
        y = esc/d(2)*(d(2)-pt{i,1}(2));
        if char(pt{i,2}) == "tuerca"
%             disp("tuerca")
%             disp([x,y])
%             t_nut = atan2(y+y0,x+x0);
%             r_nut = sqrt((x+x0)^2+(y+y0)^2);
            x_nut(nuts) = x+x0;
            y_nut(nuts) = y+y0;
            nuts = nuts+1;
%             z = 'altura de la superficie'
%             disp('enviar mensaje a robot de tuercas')
        else
%             disp("tornillo")
%             disp([x,y])
%             t_screw = atan2(y+y0,+x+x0-b);
%             r_screw = sqrt((x+x0-b)^2+(y+y0)^2);
            x_screw(screws) = x+x0;
            y_screw(screws) = y+y0;
            screws = screws +1;
%             z = 'altura de la superficie'
%             disp('enviar mensaje a robot de tornillos')
        end
    end
end 