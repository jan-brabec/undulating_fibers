function [p,f_out] = sa_p_as_der(d_omega,f,min_hz,max_hz)
% function p = sa_p_as_der(d_omega,f,min_hz,max_hz)
%
% Returns p as a derivative in a specified frequency region.

D_hi = sa_est_D_hi(d_omega,f);
d_omega = d_omega / D_hi;

ind = (f >= min_hz) & (f <= max_hz);
p = diff(log(d_omega(ind))) ./ diff(log(f(ind)));

p(end+1) = p(end);
f_out = f(ind);

end