function [G,muOD] = MC_return_G_from_G_xy(G_xy,m)
% function [G,muOD] = MC_return_G_from_G_xy(G_xy,m)
%
%   Returns structure as angles and segment lenghts from end segment
%   positions

x0 = m.x0;
y0 = m.y0;

G = [];

for i=2:size(G_xy,1)
    
    ang(i-1)  = atan((G_xy(i,2)-G_xy(i-1,2))/(G_xy(i,1)-G_xy(i-1,1)));
    length(i-1) = sqrt((G_xy(i,1)-G_xy(i-1,1))^2 + (G_xy(i,2)-G_xy(i-1,2))^2);
    
    G_incr = [length(i-1); ang(i-1)];
    G = [G G_incr];
    
end

muOD = mean(ang.^2);
