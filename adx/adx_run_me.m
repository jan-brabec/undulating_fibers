


adx_setup;

adx_traj_signals_and_info;
SNR = 1e20; %SNR = 100

d_est  = adx_est_d_from_s(m,xps,S,SNR);
d_pred = adx_pred_d(amplitude,mmuOD);

adx_plot_est_vs_pred;
adx_plot_taylor_expansions;