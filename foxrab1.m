function [value, isterminal, direction] = foxrab1(t, z, s_r, mindist, burrow)
% events function for constant speeds

r = [sqrt(2)*s_r*t/2, sqrt(2)*s_r*t/2]; % the position of the rabbit

% first event: fox reaches (gets within minimum distance of) the rabbit
value(1) = sqrt((r(1)-z(1))^2+(r(2)-z(2))^2)-mindist; % distance between fox and rabbit
isterminal(1) = 1;
direction(1) = -1;

% second event: rabbit reaches burrow
value(2) = sqrt((r(1)-burrow(1))^2+(r(2)-burrow(2))^2)-mindist; % distance between rabbit and burrow
isterminal(2) = 1;
direction(2) = -1;
end