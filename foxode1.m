function dzdt = foxode1(t, z, s_r, s_f)
% definition of the ODE

r = [sqrt(2)*s_r*t/2, sqrt(2)*s_r*t/2]; % the position of the rabbit
sw = [200,-400];
nw = [200,0]; % coordinates of corners of the warehouse

rdist = sqrt((r(1)-z(1))^2+(r(2)-z(2))^2); % the distance between the fox and the rabbit
swdist = sqrt((sw(1)-z(1))^2+(sw(2)-z(2))^2); % the distance between the fox and the corner SW

dzdt = zeros(2,1); % make sure the output is a column vector
dzdt(1) = s_f*(r(1)-z(1))/rdist; % horizontal velocity
dzdt(2) = s_f*(r(2)-z(2))/rdist; % vertical velocity

if( (z(2)<sw(2)) && (atan(abs(dzdt(2)/dzdt(1)))>=atan(abs((sw(2)-z(2))/(sw(1)-z(1))))) )
    % in the section below the warehouse, if rabbit is not visible, run straight towards SW
    dzdt(1) = s_f*(sw(1)-z(1))/swdist;
    dzdt(2) = s_f*(sw(2)-z(2))/swdist;
elseif( ((sw(2)<=z(2)) && (z(2)<nw(2)) ) && (atan(abs(dzdt(2)/dzdt(1)))<= ...
        atan(abs((nw(2)-z(2))/(nw(1)-z(1))))) )
    % in between SW and NW, if the rabbit is not visible, run north
    dzdt(1) = 0;
    dzdt(2) = s_f;
else
    dzdt(1) = s_f*(r(1)-z(1))/rdist;
    dzdt(2) = s_f*(r(2)-z(2))/rdist;
end
end