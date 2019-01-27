function f_delta_pred_1_harm = sa_pred_f_delta_1_harm(D0,a,T)
% function f_delta_pred_1_harm = sa_pred_f_delta_1_harm(D0,a,T)
%
% Returns prediction of f_delta for 1_harmonic trajectories from trajectory

pnts = 5000;
dl = 1e-7;

[x,y,~] = sa_1_harm_trajectory(a,T,pnts,dl,'1_revolution_from_left');
[~,mmuOD] = sa_muOD(x,y);

f_delta_pred_1_harm = 0.34 * D0 / a^2 * mmuOD;


% % Alternative prediction withou using muOD which works fine
% dst = sa_dst_1_harm(a,T);
% 
% D0_tilda = D0 * a^2 / dst.^2;
% 
% f_delta_pred_1_harm = 2 * pi * D0_tilda / a^2;

if f_delta_pred_1_harm > 100
    warning('f_delta predicted higher than 100 Hz. Outside of tested range')
end

end