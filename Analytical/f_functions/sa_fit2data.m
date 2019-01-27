function [s, s_i, s_e, D_w] = sa_fit2data(m,xps)
% function [s, s_i, s_e, D_w] = sa_fit2data(m,xps)
%
% Calculates signal for given model parameters.

r     = m(1);
S_0   = m(2);
f_e   = m(3);
D_0   = m(5);
D_e   = m(6);
D_inf = m(7);
shape = m(8);

%Signal
 for c_exp=1:xps.n_exp
     
  %Diffussion spectrum, dependent on model parameters
     w = xps.gwf(c_exp).w;
     D_w(c_exp,:)  = f_dips_from_r(r, shape, D_0, w);
     
     ps_q = xps.gwf(c_exp).ps_q;
     dw   = xps.gwf(c_exp).dw;
     
     %Intra- and extracelular signal
     s_i(c_exp)=exp(-sum(ps_q.*D_w(c_exp,:))*dw); %or 1/pi or 1/2pi
     s_e(c_exp)=exp(-sum(ps_q*dw)*D_e); %assuming signal is exp(-b*D_e)
     
     %Total
     s(c_exp)=S_0.*[s_i(c_exp),s_e(c_exp)]*[1-f_e;f_e];
     
 end
 
     
 
     
