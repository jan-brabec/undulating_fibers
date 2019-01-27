function v = MC_get_v_from_x(x,x_prev,dt)
%function v = MC_gen_v_from_x(x,x_prev,dt)
%
%   Returns particle velocities.

v = (x-x_prev)/dt;

end

