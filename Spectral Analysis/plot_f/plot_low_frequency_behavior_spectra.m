addpath(genpath('../../Analytical'))
addpath('../SA_functions')
addpath('../res')
figure;
clf
D0 = 1.7e-9;

%1-harmonic plot
load res_1_10.mat

one_harm_f_1 = f;
one_harm_omega_1 = sa_put_d_omega2zero(ft_ac,f);
D_hi_est_1_harm_1 = sa_est_D_hi(one_harm_omega_1,one_harm_f_1);

load res_3_50.mat
one_harm_f_2 = f;
one_harm_omega_2 = sa_put_d_omega2zero(ft_ac,f);
D_hi_est_1_harm_2 = sa_est_D_hi(one_harm_omega_2,one_harm_f_2);

% n-harmonic plot
load res_probe_n_harm.mat

n_harm_f = f;
n_harm_d_omega = d_omega_avd_s(1,:);
D_hi_est_n_harm = sa_est_D_hi(n_harm_d_omega,n_harm_f);

%stochastic plot
load res_stoch_b1.mat

stoch_f = f;
stoch_d_omega = sa_put_d_omega2zero(ft_ac,f);
D_hi_est_stoch = sa_est_D_hi(stoch_d_omega,stoch_f);

% normal plot

plot(one_harm_f_1,one_harm_omega_1/D_hi_est_1_harm_1,'-','Linewidth',4,'Color',pl_color('1-harm'));
hold on;
plot(one_harm_f_2,one_harm_omega_2/D_hi_est_1_harm_2,'-.','Linewidth',4,'Color',pl_color('1-harm'))
plot(n_harm_f,n_harm_d_omega/D_hi_est_n_harm,'--','Linewidth',4,'Color',pl_color('n-harm'))
plot(stoch_f,stoch_d_omega/D_hi_est_stoch,':','Linewidth',4,'Color',pl_color('stoch'))

h = legend('1-harmonic','1-harmonic','n-harmonic','stochastic','Location','southeast');
pos = get(h,'Position');
posx = 0.65;
posy = 0.37;
set(h,'Position',[posx posy pos(3) pos(4)]);

xlim([0 50])
xticks([0 25 50])

ylim([0 1])
yticks([0 0.5 1])

xlabel('{\itf} [Hz]')
ylabel('D({\itf}) [a.u.]')

plot_set_2x2;


% log-log plot
figure;

loglog(one_harm_f_1,one_harm_omega_1/D_hi_est_1_harm_1,'-','Linewidth',4,'Color',pl_color('1-harm'))
hold on
loglog(one_harm_f_2,one_harm_omega_2/D_hi_est_1_harm_2,'-.','Linewidth',4,'Color',pl_color('1-harm'))

loglog(n_harm_f,n_harm_d_omega/D_hi_est_n_harm,'--','Linewidth',4,'Color',pl_color('n-harm'))
loglog(stoch_f,stoch_d_omega/D_hi_est_stoch,':','Linewidth',4,'Color',pl_color('stoch'))

f = linspace(0,1000,1e4);
loglog(f,170 * abs(1 - 1 ./ (1 + (f / 1000).^1)), '-.', 'linewidth', 4,'Color', pl_color('cyl_fit'));
loglog(f, 50 * abs(1 - 1 ./ (1 + (f /1000).^2)), '--', 'linewidth', 4,'Color', pl_color('cyl_fit'));

xlabel('log {\itf} [Hz]')
ylabel('log D({\itf}) [a.u]')

legend('1-harmonic','1-harmonic','n-harmonic','stochastic','{\itf}^1','{\itf}^2','Location','southeast')

xticks([10^0 10^1 10^2])
xlim([10^0 10^2])
ylim([10e-5 5])

yticks([1e-4 1e-2 1])

plot_set_2x2;


%derivative plot
figure;

[p_h1,one_harm_f_1] = sa_p_as_der(one_harm_omega_1,one_harm_f_1,1,50);
[p_h2,one_harm_f_2] = sa_p_as_der(one_harm_omega_2,one_harm_f_2,1,50);
[p_n,n_harm_f]      = sa_p_as_der(n_harm_d_omega,n_harm_f,1,50);
[p_s,stoch_f]       = sa_p_as_der(stoch_d_omega,stoch_f,1,50);


plot(f,ones(1,numel(f)), '-.', 'linewidth', 4,'Color', pl_color('cyl_fit'));
hold on
plot(f,ones(1,numel(f))*2, '--', 'linewidth', 4,'Color', pl_color('cyl_fit'));

plot(one_harm_f_1,smooth(p_h1,7),'-','Color',pl_color('1-harm'),'Linewidth',4);
hold on
plot(one_harm_f_2,p_h2,'-.','Color',pl_color('1-harm'),'Linewidth',4);
plot(n_harm_f,p_n,'--','Color',pl_color('n-harm'),'Linewidth',4);
plot(stoch_f,smooth(p_s,1),':','Color',pl_color('stoch'),'Linewidth',4);

xlim([0 20])
xticks([0 5 10 15  20])
xlabel('{\itf} [Hz]')
plot_set_2x2;
ylabel('{\itp}_{derivative}')
legend off






