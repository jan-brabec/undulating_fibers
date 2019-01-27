function est_diam = adx_est_d_from_s(m,xps,S,SNR)
% function d_pred = adx_pred_d(amplitude,mmuOD)
%
% Returns estimated diameters from signal of the trajectory


f = @(d,t) adx_1d_fit2data([ m(1:10) d], xps);

n_rep = 10;
d_fit = zeros(n_rep, size(S,2));

for c1 = 1:size(S,2)
    
    s = S(:,c1);

    for c2 = 1:n_rep
        s_noise = s + randn(size(s)) / SNR;
        
        opt = optimoptions('lsqcurvefit', 'display', 'off','MaxFunEvals',1e4);
        opt.OptimalityTolerance = 1e-10;
        d_fit(c2,c1) = msf_fit(f, s_noise, 0, 20e-6, 3, opt);
    end
end

est_diam = mean(d_fit,1);
