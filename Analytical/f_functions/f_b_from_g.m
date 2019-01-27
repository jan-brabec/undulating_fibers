function b = f_b_from_g(g,dt)
% function b = f_b_from_g(g,dt)
%
% Returns b-value from gradient g(t)

b    =  f_b_t_from_q_t(f_q_t_from_g(g,dt),dt);

end