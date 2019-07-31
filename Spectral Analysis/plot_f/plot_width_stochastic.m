clf
clear all
addpath('../SA_functions')
addpath('../res')



for c_case = 1:7
    
    
    switch c_case
        case 1
            load res_stoch_2_longer_time_lower_dt_until_10s.mat;
        case 2
            load res_stoch_3_longer_time_lower_dt_until_10s.mat;
        case 3
            load res_stoch_4_longer_time_lower_dt_until_10s.mat;
        case 4
            load('res_stoch_b1.mat');
        case 5
            load('res_stoch_b2.mat');
        case 6
            load('res_stoch_b3.mat');
        case 7
            load('res_stoch_b4.mat');
    end

    
    d_omega = sa_put_d_omega2zero(ft_ac,f);
    
    x = G_xy(:,1);
    y = G_xy(:,2);
    D0 = 1.7e-9;

    f_delta_est_stoch(c_case)  = sa_est_f_delta(d_omega,f);
    f_delta_pred_stoch(c_case) = sa_pred_f_delta_stoch(D0,a,x,y);
    
     if (0) %debug
        clf;
        D_hi_est = sa_est_D_hi(d_omega,f);
        plot(f, d_omega); hold on;
        plot([0 0] + f_delta_est_stoch(c_case), [0 2e-10], 'linewidth', 2);
        plot([0 0] + f_delta_pred_stoch(c_case), [0 2e-10], 'linewidth', 2);
        plot(f, zeros(size(f)) + D_hi_est, 'linewidth', 2);
        xlim([0 400]);
        ylim([0 4e-10]);
        title(sprintf('a = %1.2f, t = %1.2f', a * 1e6, T * 1e6));
       
        pause;
    end
    
end

clf;
plot([0 100],[0 100],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(f_delta_pred_stoch,f_delta_est_stoch,'.','Markersize',80,'Color',pl_color('stoch'))

xlim([0 100])
ylim([0 100])

yticks([0 50 100])
xticks([0 50 100])

% ylabel('Estimated {\itf_{\Delta}}')
xlabel('Predicted {\itf_{\Delta}}')

plot_set_1x3;

legend off;


R = corrcoef(f_delta_pred_stoch,f_delta_est_stoch)




