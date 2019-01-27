function f_delta_pred_n_harm_from_1_harm = sa_pred_f_delta_n_harm_from_1_harm(f_delta_1_harm,D_hi_1_harm)
% function f_delta_pred_n_harm_from_1_harm = sa_pred_f_delta_n_harm_from_1_harm(weights,f_delta_1_harm,D_hi_1_harm)
%
% Predicts f_delta of a n-harmonic from 1-harmonics when 

f_delta_pred_n_harm_from_1_harm = sum(D_hi_1_harm .* f_delta_1_harm) / sum(D_hi_1_harm);

if f_delta_pred_n_harm_from_1_harm > 100
    warning('f_delta predicted higher than 100 Hz. Outside of tested range')
end

end

