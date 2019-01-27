function f_delta_est = sa_est_f_delta(d_omega,f)
% function f_delta_est = sa_est_f_delta(d_omega,f)
%
% Estimates f_delta from spectrum

D_hi_est = sa_est_D_hi(d_omega,f);

ind = find( (d_omega > 1/2 * D_hi_est) & (f < 5350) & (f > 0), 1, 'first');
f_delta_est = abs(f(ind));


end