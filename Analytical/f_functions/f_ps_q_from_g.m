function [ps_q,f] = f_ps_q_from_g(g,t)
% function [ps_q,f] = f_ps_q_from_g(g,t)
%
%   Returns power spectra of q vectors from gradient vectors g(t).

dt = t(2) - t(1);
f = f_gen_freq_from_time(t, dt);


q_t = f_q_t_from_g(g,dt);
q_w = f_q_w_from_q_t(q_t,dt,f);
ps_q = f_ps_q_w_from_q_w(q_w);