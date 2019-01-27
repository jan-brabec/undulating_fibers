function b_w = f_b_w_from_ps_q(ps_q,dw)
% function b_w = f_b_w_from_ps_q(ps_q,df)
%
% Returns b-value from power spectrum of q(w).
% b(w) is a definite integral over |q(w)|^2 over all values of w
    
    b_w = sum(ps_q*dw,2); %s/m^2; 
    