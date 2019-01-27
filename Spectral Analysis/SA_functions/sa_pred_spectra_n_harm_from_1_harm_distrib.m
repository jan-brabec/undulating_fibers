function [f_delta_pred,D_hi_pred] = sa_pred_spectra_n_harm_from_1_harm_distrib(a,T,D0)
% function f_delta_pred_n_harm_from_1_harm = sa_pred_spectra_n_harm_from_1_harm_distrib(weights,a,T)
%
% Predicts f_delta of a n-harmonic from 1-harmonics


for c_case = 1:numel(a) %compute first 1-harmonics
%     f_delta_1_harm(c_case) = sa_pred_f_delta_1_harm(D0,a(c_case),T(c_case));
    
    f_delta__pred_1_harm(c_case) = sa_pred_f_delta_1_harm_muOD(D0,a(c_case),T(c_case));

    pnts = 5000; dl = 1e-7;
    [x,y] = sa_1_harm_trajectory(a(c_case),T(c_case),pnts,dl,'1_revolution_from_left');
    
    D_hi_pred_1_harm(c_case) = sa_pred_D_hi(x,y,D0);
end

%combine them to get n-harmonics
D_hi_pred    = sa_pred_D_hi_n_harm_from_1_harm(D_hi_pred_1_harm);
f_delta_pred = sa_pred_f_delta_n_harm_from_1_harm(f_delta__pred_1_harm,D_hi_pred_1_harm);


end

