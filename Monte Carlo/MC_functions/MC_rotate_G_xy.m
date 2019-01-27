function G_xy_rot = MC_rotate_G_xy(G_xy)
% function G_xy = MC_rotate_G_xy(G_xy)
% 
% Rotates G_xy such that macroscopic orientation dispersion = 0

p = polyfit(G_xy(:,1),G_xy(:,2),1);

theta = -atan(p(1)); %rotation angle in rad


G_xy_rot = [1 1];
for i=1:size(G_xy,1)
    G_xy_rot(i,1) = G_xy(i,1)*cos(theta) - G_xy(i,2)*sin(theta);
    G_xy_rot(i,2) = G_xy(i,1)*sin(theta) + G_xy(i,2)*cos(theta);
end


end
