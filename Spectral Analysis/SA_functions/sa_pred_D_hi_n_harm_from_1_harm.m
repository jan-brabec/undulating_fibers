function D_hi_pred = sa_pred_D_hi_n_harm_from_1_harm(D_hi_1_harm)
% function D_hi_pred_n_harm_from_1_harm = sa_pred_D_hi_n_harm_from_1_harm(weigths,D_hi_1_harm)
%
% Predicts D_hi of a n-harmonic from 1-harmonics

n_samples = numel(D_hi_1_harm);

D_hi_pred = sum(D_hi_1_harm)/n_samples;

if D_hi_pred*1e9 > 1.1
    warning('Predicted D_hi in the untested region')
end

end