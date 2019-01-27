% addpath('../Monte Carlo/MC_functions')
% addpath('../Spectral Analysis/SA_functions')
% addpath(genpath('../Analytical'))
addpath('GS_trajectories')
addpath('GS_functions')


load GS_trajectories/res_stoch_b4.mat
clearvars -except a T G_xy cind dl

info = 'running b4 on dt = 1e-5 to see if the prediction is better, because it is quite off now, dd = 1e-7, t_max = 10 s';


if (1)
    %time
    t_max = 10;
    dt = 1e-4; %1e-5 best, dt = 1e-4 ok
    t = linspace(0, t_max,round(t_max/dt)+1);
    [f,~] = f_gen_freq_from_time(t,dt);
    
    x_act = G_xy(:,1);
    y_act = G_xy(:,2);
    a = a;
    T = T;
    D0 = 1.7e-9;
    
    msd = gs_sim(t,D0,y_act,cind,dl,'parallel_yes',0,dt,f);
    save tmp.mat

end

if (0)
    
    % plot
    d_omega = MC_ft_of_ac(MC_get_ac_from_msd(msd,dt),dt);
    d_omega = sa_put_d_omega2zero(d_omega,f);
    
    clf;
    
    D_hi_pred = sa_pred_D_hi(x_act,y_act,D0);
    D_hi_est = sa_est_D_hi(d_omega,f);
    
    f_delta_pred_1_harm = sa_pred_f_delta_1_harm(D0,a,T);
    f_delta_pred_stoch = sa_pred_f_delta_stoch(D0,a,x_act,y_act);
    
    f_delta_est = sa_est_f_delta(d_omega,f);
    
    
    plot(f,d_omega*1e9); hold on;
    hold on
    plot([0 0] + f_delta_est, [0 D_hi_est*1e9], 'linewidth', 2);
    plot([0 0] + f_delta_pred_1_harm, [0 D_hi_est*1e9], 'linewidth', 2);
    plot([0 0] + f_delta_pred_stoch, [0 D_hi_est*1e9], 'linewidth', 2);
    plot(f, zeros(size(f)) + D_hi_est*1e9, 'linewidth', 2);
    plot(f, zeros(size(f)) + D_hi_pred*1e9, 'linewidth', 2);
    xlim([0 500]);
    title(sprintf('a = %1.2f, T = %1.2f', a * 1e6, T * 1e6));
    
end

gcp('nocreate')