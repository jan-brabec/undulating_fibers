addpath('GS_trajectories')
addpath('GS_functions')
addpath('../Monte Carlo/MC_functions')
addpath('../Spectral Analysis/SA_functions')
addpath('../Analytical/f_functions')


load GS_trajectories/res_stoch_b1.mat
clearvars -except a T G_xy cind dl

cind = 17500:42500;

info = 'running b1 but on dt = 1e-5, dd = 1e-7, t_max = 10 s for 60 revolutions with ds = 50 otherwise too large';

if (1)
    %time
    t_max = 10;
    dt = 1e-4; %1e-5 best, 1e-4 ok
    t = linspace(0, t_max,round(t_max/dt)+1);
    [f,df] = f_gen_freq_from_time(t,dt);
    
    x_act = G_xy(:,1);
    y_act = G_xy(:,2);
    a = a;
    T = T;
    D0 = 1.7e-9;
    
    [msd,sd_by_step,d_omega_by_step] = gs_sim(t,D0,y_act,cind,dl,'parallel_yes',1,dt,f);
    save b1_60_rev_final.mat %the rest is in tmp.mat
end


% plot standard
if (0)
    d_omega = MC_ft_of_ac(MC_get_ac_from_msd(msd,dt),dt);
    d_omega = sa_put_d_omega2zero(d_omega,f);
    
    D_hi_pred = sa_pred_D_hi(x_act,y_act,D0);
    D_hi_est = sa_est_D_hi(d_omega,f);
    
    f_delta_pred_1_harm = sa_pred_f_delta_1_harm(D0,a,T);
    f_delta_pred_stoch = sa_pred_f_delta_stoch(D0,a,x_act,y_act);
    f_delta_est = sa_est_f_delta(d_omega,f);
    
    clf;
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


if (0) %plot course of improvement
    disp('press any key');
    pause;
    clf;
    ds = 10;
    ts = t(1:ds:end);
    fs = f(1:ds:end);
    
    for i =  1:20:numel(cind)
        
        subplot(3,1,1)
        plot(fs, d_omega_by_step(:,i)*1e9, 'linewidth', 2);
        hold on
        plot(f, d_omega*1e9, 'linewidth', 2);
        xlabel('f')
        ylabel('D(f) [μm^2/ms]')
        xlim([0 500])
        title(['Diffusion spectra; ',num2str(i),''])
        drawnow;
        hold off
        
        subplot(3,1,2)
        msd_by_step = sd_by_step(:,i)/i;
        plot(ts,msd_by_step*1e12, 'linewidth', 2);
        hold on
        plot(t, msd*1e12, 'linewidth', 2);
        xlim([0 0.2])
        title(['msd; ',num2str(i),''])
        xlabel('t')
        ylabel('msd(t) [μm^2]')
        drawnow;
        hold off
        
        subplot(3,1,3)
        plot(G_xy(cind,1),G_xy(cind,2),'linewidth',2)
        hold on;
        plot(G_xy(cind(1:i),1),G_xy(cind(1:i),2),'linewidth',3)
        axis equal
        title(['trajectory; ',num2str(i),''])
        drawnow;
        xlabel('x [μm]')
        ylabel('y [μm]')
        
        hold off
    end
    
end


gcp('nocreate')
