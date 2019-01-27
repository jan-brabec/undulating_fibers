function [D_hi,f_delta] = sa_fit_lorentz(d_omega,f,f0,f_max)
% function [D_hi,f_delta] = sa_fit_lorentz(d_omega,f,f0,f_max)
%
% Fits Lorentzian in a standard way

if nargin > 3
    [d_omega,f] = sa_restrict_freq(d_omega,f,f0,f_max);
end

lorenz1 = @(t,f)t(1)*f.^2./(t(2).^2+f.^2);

opt = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective',...
    'display', 'off','MaxFunEvals',1e4,'OptimalityTolerance',1e-12);

low_bound = [0,0];
upper_bound = [100,500];
n_rep = 5;

rs = inf;
for i=1:n_rep

    t0 = rand(1,2).*upper_bound+low_bound;
    [tmp_fit_param,rs_new] = lsqcurvefit(lorenz1,t0,f,d_omega*1e10,low_bound,upper_bound,opt);
    
    if rs_new < rs
        fit_param = tmp_fit_param;
        rs = rs_new;
    end
end

D_hi = fit_param(1)*1e-10;
f_delta = fit_param(2);

end

