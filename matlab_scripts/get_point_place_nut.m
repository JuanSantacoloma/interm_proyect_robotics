function [point2place] = get_point_place_nut(count_place)
    point2place = zeros(1,3);
     
    switch(count_place)
        case 1
            point2place = [1.4,-0.7,1.1]*100;
        case 2
            point2place = [1.712,-0.7,1.1]*100;
        case 3
            point2place = [2.032,-0.7,1.1]*100;
        case 4
            point2place = [1.90,-0.7,1.1]*100;
    end
end