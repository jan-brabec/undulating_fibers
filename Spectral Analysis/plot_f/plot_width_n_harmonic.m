clf
clear all

f_delta_est_n_harm = 0;
while max(f_delta_est_n_harm)<78
    
    
    
    load ../res/res_probe_n_harm.mat
    
    f_delta_est_n_harm = f_delta_est;
    f_delta_pred_n_harm = f_delta_pred;
    
    f_delta_est_n_harm(isnan(f_delta_est_n_harm)) = [];
    f_delta_pred_n_harm(isnan(f_delta_pred_n_harm)) = [];
    
    f_delta_est_n_harm(end) = [];
    
    
    n_samples = 20;
    
    del = numel(f_delta_est_n_harm)-n_samples; %delete randomly the diff so that we get target number of samples
    ind = randperm(numel(f_delta_est_n_harm),del);
    f_delta_est_n_harm(ind) = [];
    f_delta_pred_n_harm(ind) = [];
    
end

clf;
plot([0 100],[0 100],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(f_delta_pred_n_harm,f_delta_est_n_harm,'.','Markersize',80,'Color',pl_color('1-harm'))

xlim([0 100])
ylim([0 100])

yticks([0 50 100])
xticks([0 50 100])

% % ylabel('Estimated {\itf_{\Delta}} [Hz]')
xlabel('Predicted {\itf_{\Delta}}')


plot_set_1x3;
legend off;

R = corrcoef(f_delta_pred_n_harm,f_delta_est_n_harm)


