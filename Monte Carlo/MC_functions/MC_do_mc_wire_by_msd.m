function [p, x] = MC_do_mc_wire_by_msd(p,mss,m)
% function [p, x, G_xy] = MC_do_mc_wire_by_msd(p,mss,m)
%
%   Runs Monte Carlo simulation along a line and returns particle
%   velocities, positions both at the line and structure
%   and structure where it diffuses

n_step = round(mss.ac.dt/mss.mc.dt);

for c=1:n_step
  
    p = p + normrnd(0,mss.p.dp,mss.particles,1);
    p = MC_apply_const_restrictions(p,mss.p.p_start,mss.p.p_end,mss.reflectance);
    
end

x = MC_p2xy(p,m.struc,m.x0,m.y0);

end

