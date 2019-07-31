clear all

D_hi_est_n_harm = 0;
vv = 0;

while max(D_hi_est_n_harm)<0.78e-9

load ../res/res_probe_n_harm.mat



D_hi_est_n_harm = D_hi_est;
D_hi_pred_n_harm = D_hi_pred;

D_hi_est_n_harm(isnan(D_hi_est_n_harm)) = [];
D_hi_pred_n_harm(isnan(D_hi_pred_n_harm)) = [];

D_hi_est_n_harm(end) = [];


n_samples = 20;

del = numel(D_hi_est_n_harm)-n_samples; %delete randomly the diff so that we get target number of samples
ind = randperm(numel(D_hi_est_n_harm),del);
D_hi_est_n_harm(ind) = [];
D_hi_pred_n_harm(ind) = [];

end 


clf

plot([0 1.2],[0 1.2],'--','Color',pl_color('line'),'Linewidth',10)
hold on
plot(D_hi_pred_n_harm*1e9,D_hi_est_n_harm*1e9,'.','Markersize',80,'Color',pl_color('n-harm'))

xlim([0 1.1])
ylim([0 1.1])

yticks([0 0.5 1])
xticks([0 0.5 1])

% ylabel('Estimated {\itD_{hi}} [μm^2/ms]')
% xlabel('Predicted {\itD_{hi}} [μm^2/ms]')


plot_set_1x3;
legend off;

R = corrcoef(D_hi_pred_n_harm*1e9,D_hi_est_n_harm*1e9)


