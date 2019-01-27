function b_t = f_b_t_from_q_t(q_t,dt)
% function b_t = f_b_t_from_q_t(q_t,dt)
%
% Returns b-value from q(t).
% b(t) is a definite integral over |q(t)|^2 over all values of t
    
    b_t = sum(abs(q_t).^2*dt,2); %s/m^2; 