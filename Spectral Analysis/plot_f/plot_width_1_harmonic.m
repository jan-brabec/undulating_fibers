clf
clear all
addpath('../res')
addpath('../SA_functions')


for c_exp = 1:15
    
    
    switch c_exp
        case 1
            load 'res_1_10.mat'
        case 2
            load 'res_1_20.mat'
        case 3
            load 'res_1_30.mat'
        case 4
            load 'res_1_40.mat'
        case 5
            load 'res_1_50.mat'
            
            
        case 6
            load 'res_2_10.mat'
        case 7
            load 'res_2_20.mat'
        case 8
            load 'res_2_30.mat'
        case 9
            load 'res_2_40.mat'
        case 10
            load 'res_2_50.mat'
            
        case 11
            load 'res_3_10.mat'
        case 12
            load 'res_3_20.mat'
        case 13
            load 'res_3_30.mat'
        case 14
            load 'res_3_40.mat'
        case 15
            load 'res_3_50.mat'
    end
    clear w_est
    
    
    d_omega = sa_put_d_omega2zero(ft_ac,f);
    
    f_delta_est_1_harm(c_exp) = sa_est_f_delta(d_omega,f);
    f_delta_pred_1_harm(c_exp) = sa_pred_f_delta_1_harm(D0,a,T);
    
    if (0) %debug
        clf;
        D_hi_est = sa_est_D_hi(d_omega,f);
        plot(f, d_omega); hold on;
        plot([0 0] + f_delta_est(c_exp), [0 2e-10], 'linewidth', 2);
        plot([0 0] + f_delta_pred_1_harm(c_exp), [0 2e-10], 'linewidth', 2);
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
plot(f_delta_pred_1_harm,f_delta_est_1_harm,'.','Markersize',80,'Color',pl_color('1-harm'));
legend off

yticks([0 50 100])


ylabel('Estimated {\itf}_{\Delta} [Hz]')
xlabel('Predicted {\itf}_{\Delta} [Hz]')

plot_set_1x3;

legend off


R = corrcoef(f_delta_pred_1_harm,f_delta_est_1_harm)

