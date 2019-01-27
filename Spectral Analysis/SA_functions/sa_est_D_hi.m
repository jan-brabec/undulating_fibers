function D_hi_est = sa_est_D_hi(d_omega,f)
% function D_hi_est = sa_est_D_hi(d_omega,f)
%
% Estimates D_hi from spectrum, fit at frequency at the last 10 %
% or less than 850 Hz.

if max(f) > 1000
    f_max = 1000;
else
    f_max = max(f);
end

f0    = f_max*0.90;

[d_omega,f] = sa_restrict_freq(d_omega,f,f0,f_max);

warning off;
slope = polyfit(f, d_omega, 1);
warning on;

if slope(1) > 1e-13
    warning('diffusion spectra may have not reached stationary value')
end


D_hi_est = mean(d_omega);

if f_max<150
    error('f_max is not high enough')
end

if D_hi_est*1e9 > 1.1
    warning('D_hi estimated higher than 1.1. Outside of tested range')
end



end