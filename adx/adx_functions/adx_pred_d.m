function d_pred = adx_pred_d(amplitude,mmuOD)
% function d_pred = adx_pred_d(amplitude,mmuOD)
%
% Returns prediction of cylinder diameter from trajectory model parameters,
% amplitude and microscopic orientation dispersion.

k_c = 2.35;
k_h = 0.34;
k = sqrt(k_c/k_h);

d_pred = k * amplitude ./ mmuOD.^(1/4);


end