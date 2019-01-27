function [p, f_min, f_max] = sa_fit_p(d_omega,f,min_hz,max_hz,min_d_omega,max_d_omega)
% function [p, f_min, f_max] = sa_fit_p(d_omega,f,min_hz,max_hz,min_d_omega,max_d_omega)
%
% Returns p in a specified fitting region.

D_hi = sa_est_D_hi(d_omega,f);

ind = (d_omega >= min_d_omega * D_hi) & (d_omega <= max_d_omega * D_hi) & (f >= min_hz) & (f <= max_hz);

pv = polyfit(log(f(ind)), log(d_omega(ind)), 1);

p = pv(end-1);

f_min = f(find(ind==1,1,'first'));
f_max = f(find(ind==1,1,'last'));

end

