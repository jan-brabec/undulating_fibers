function msd = MC_get_msd_from_x(x_act,x_init)
% function msd = MC_get_msd_from_x(x_act,x_init)
%
%   Returns mean square displacement from initial and actual particle position.

sd  = (x_act-x_init).^2;
msd = mean(sd);

end
