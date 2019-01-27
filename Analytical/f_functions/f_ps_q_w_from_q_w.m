function ps_q = f_ps_q_w_from_q_w(q_w);
% function ps_q = f_ps_q_w_from_q_w(q_w);
%
% Returns power spectrum of q(w) vector from q(w) vector.
    
    ps_q = abs(q_w).^2;