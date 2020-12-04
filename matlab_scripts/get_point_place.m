function [MTH_point_place] = get_point_place(count_place)
   MTHs_place_points = zeros(4,4,28);
%   Columna 1 1.372,0.2445,0.3500
    MTHs_place_points(:,:,1) = transl(1.372,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,2) = transl(1.712,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,3) = transl(2.032,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,4) = transl(2.250,0.2445,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 2
    MTHs_place_points(:,:,5) = transl(2.250,0.0245,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,6) = transl(2.032,0.0245,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,7) = transl(1.712,0.0245,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,8) = transl(1.372,0.0245,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 3
    MTHs_place_points(:,:,9) = transl(1.372,-0.1955,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,10) = transl(1.712,-0.1955,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,11) = transl(2.032,-0.1955,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,12) = transl(2.250,-0.1955,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 4
    MTHs_place_points(:,:,13) = transl(2.250,-0.4155,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,14) = transl(2.032,-0.4155,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,15) = transl(1.712,-0.4155,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,16) = transl(1.372,-0.4155,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 5
    MTHs_place_points(:,:,17) = transl(1.372,-0.6355,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,18) = transl(1.712,-0.6355,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,19) = transl(2.032,-0.6355,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,20) = transl(2.032,-0.6355,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 6
    MTHs_place_points(:,:,21) = transl(2.032,-0.8555,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,22) = transl(2.032,-0.8555,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,23) = transl(1.712,-0.8555,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,24) = transl(1.372,-0.8555,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    %   Columna 7
    MTHs_place_points(:,:,25) = transl(1.372,-1.0755,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,26) = transl(1.712,-1.0755,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,27) = transl(1.712,-1.0755,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');
    MTHs_place_points(:,:,28) = transl(1.712,-1.0755,0.3500)*rpy2tr(180, 2.25, -90.0, 'deg');    
    
    MTH_point_place = MTHs_place_points(:,:,count_place);
end