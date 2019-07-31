clf;
clear all
addpath('../res')
addpath('../SA_functions')

for c_case = 1:7
    
    
    switch c_case
        case 1
            load('res_stoch_2_longer_time_lower_dt_until_10s.mat');
        case 2
            load('res_stoch_3_longer_time_lower_dt_until_10s.mat');
        case 3
            load('res_stoch_4_longer_time_lower_dt_until_10s.mat');
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
    
    D_hi_est_stoch(c_case)  = sa_est_D_hi(d_omega,f);
    D_hi_pred_stoch(c_case) = sa_pred_D_hi(x,y,D0);
    
end

plot([0 1.1],[0 1.1],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(D_hi_pred_stoch*1e9,D_hi_est_stoch*1e9,'.','Markersize',80,'Color',pl_color('1-harm'))

xlim([0 1.1])
ylim([0 1.1])

yticks([0 0.5 1])
xticks([0 0.5 1])


% ylabel('Estimated {\itD_{hi}} [μm^2/ms]')
% xlabel('Predicted {\itD_{hi}} [μm^2/ms]')

plot_set_1x3;
legend off;



R = corrcoef(D_hi_pred_stoch*1e9,D_hi_est_stoch*1e9)

