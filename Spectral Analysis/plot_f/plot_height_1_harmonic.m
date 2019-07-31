
clf
clear all
addpath('../res')
addpath('../SA_functions')

D0 = 1.7e-9;


for c_case = 1:15
    
    
    switch c_case
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
    
    d_omega = sa_put_d_omega2zero(ft_ac,f);
    x = G_xy(:,1);
    y = G_xy(:,2);
    
    D_hi_est(c_case)  = sa_est_D_hi(d_omega,f);
    D_hi_pred(c_case) = sa_pred_D_hi(x,y,D0);
    
end

clf
plot([0 1.2],[0 1.2],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(D_hi_pred*1e9,D_hi_est*1e9,'.','Markersize',80,'Color',pl_color('1-harm'))

xlim([0 1.1])
ylim([0 1.1])

yticks([0 0.5 1])
xticks([0 0.5 1])
ylabel('Estimated {\itD}_{hi} [µm^2/ms]')
xlabel('Predicted {\itD}_{hi} [µm^2/ms]')

plot_set_1x3;
legend off;

R = corrcoef(D_hi_pred*1e9,D_hi_est*1e9)


