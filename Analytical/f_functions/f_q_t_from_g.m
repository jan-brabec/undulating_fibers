function q_t = f_q_t_from_g(g,dt)
% function q_t = f_q_t_from_g(g,dt)
%
% Returns q(t) vector from gradient g(t) in certain experiment.

    gamma = f_gamma();
    q_t = gamma * cumsum(g*dt,2);