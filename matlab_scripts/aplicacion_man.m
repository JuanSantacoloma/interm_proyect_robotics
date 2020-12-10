%% Tratamiento de imagen

im = imread("vision_maquina/I8.jpeg"); % lectura de la imagen
imshow(im)

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
imshow(tr)

%% Identificación de elementos
rc = bwconncomp(tr)

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


%% Organización de los elementos
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

%% Ubicación de elementos en magnitud física
esc = 200; % Escala de conversion (200 mm)
x0 = 20; % Distancia entre el SC del primer robot y de la base sobre x.
y0 = 40; % Distancia entre el SC del primer robot y de la base sobre y.
b = 240; % Distancia entre los dos robots sobre x.
%% 
%% 
%rosinit;
%% Creación del Publicador y tipo de mensaje 
[pub1,msg1] = phantom_publisher('/robot1');
[pub2,msg2] = phantom_publisher('/robot2');
%% Creación del Suscriptor
sub1=rossubscriber('/robot1/joint_states');
sub2=rossubscriber('/robot2/joint_states');
qs=zeros(6,6);
%% trayectoria
%% 

for i = 1:length(pt)
    i
    x = esc/d(1)*pt{i,1}(1)
    y = esc/d(1)*pt{i,1}(2)
    if char(pt{i,2}) == "tuerca"
        xr=x+x0
        yr=y+y0
        Xo=[y0+y,-(x+x0),136];
        Xf=[-200,0,94];
        picknplace(Xo,Xf,pub2,sub2,msg2)
    else
        disp('enviar mensaje a robot de tornillos')
        xr=x+x0-b
        yr=y+y0
        Xo=[y+y0,-(x+x0-b),136];
        Xf=[-200,0,94];
        picknplace(Xo,Xf,pub1,sub1,msg1)
    end
end

%% 
%picknplace([200,0,100],[200,0,100],pub1,sub1,msg1)