function f_delta_pred_stoch = sa_pred_f_delta_stoch(D0,a_max,x,y)
% function f_delta_pred_stoch = sa_pred_f_delta_stoch(D0,a_max,x,y)
%
% Returns prediction of f_delta for stochastic trajectories from trajectory

[muOD,mmuOD] = sa_muOD(x,y);

D0_tilda = D0 * mean(muOD.^2)/mmuOD;
f_delta_pred_stoch = 0.13 * D0_tilda/a_max.^2;


% Alternative prediction that yields the same results but with higher
% variance but not used

% D0_tilda = D0 * mmuOD;
% f_delta_pred_stoch = 0.4026 * D0_tilda/a_max.^2;


if f_delta_pred_stoch > 100
    warning('f_delta predicted higher than 100 Hz. Outside of tested range')
end


end

