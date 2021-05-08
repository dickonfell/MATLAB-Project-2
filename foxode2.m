function dzdt = foxode2(t, z, sr, sf)
% definition of the ODE including equations for the diminishing speeds

sf = sf*exp(-0.0002*sf*t); % equation for the diminishing speed of the fox
sr = sr*exp(-0.0008*sr*t); % equation for the diminishing speed of the rabbit
r = [sqrt(2)*sr*t/2, sqrt(2)*sr*t/2]; % the position of the rabbit
sw = [200,-400];
nw = [200,0]; % coordinates of corners of the warehouse

rdist = sqrt((r(1)-z(1))^2+(r(2)-z(2))^2); % the distance between the fox and the rabbit
swdist = sqrt((sw(1)-z(1))^2+(sw(2)-z(2))^2); % the distance between the fox and the corner sw

dzdt = zeros(2,1); % make sure the output is a column vector
dzdt(1) = sf*exp(-0.0002*sf*t)*(r(1)-z(1))/rdist; % horizontal velocity
dzdt(2) = sf*exp(-0.0002*sf*t)*(r(2)-z(2))/rdist; % vertical velocity

if( (z(2)<sw(2)) && (atan(abs(dzdt(2)/dzdt(1)))>=atan(abs((sw(2)-z(2))/(sw(1)-z(1))))) )
    % in the section below the warehouse, if rabbit is not visible, run straight towards SW
    dzdt(1) = sf*exp(-0.0002*sf*t)*(sw(1)-z(1))/swdist;
    dzdt(2) = sf*exp(-0.0002*sf*t)*(sw(2)-z(2))/swdist;
elseif( ((sw(2)<=z(2)) && (z(2)<nw(2))) && (atan(abs(dzdt(2)/dzdt(1)))<=atan(abs((nw(2)-z(2))/(nw(1)-z(1))))) )
    % in between SW and NW, if the rabbit is not visible, run north
    dzdt(1) = 0;
    dzdt(2) = sf*exp(-0.0002*sf*t);
else
    dzdt(1) = sf*exp(-0.0002*sf*t)*(r(1)-z(1))/rdist;
    dzdt(2) = sf*exp(-0.0002*sf*t)*(r(2)-z(2))/rdist;
end
end