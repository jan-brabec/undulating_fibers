clear all;

addpath(genpath('../../Analytical'))
addpath('../SA_functions')
addpath('../res')


D0 = 1.7e-9;






%cylinder plot
r = 10e-6;
cyl_f = linspace(0,150,1e5+1);
cyl_d_omega = f_dips_from_r(r, 2, D0, cyl_f);

[D_hi,f_delta] = sa_fit_lorentz(cyl_d_omega,cyl_f);


figure;
plot(cyl_f,cyl_d_omega*1e9,'-','Linewidth',14,'Color',pl_color('cyl')) %[0.7529    0.3451    0.0196]
hold on;
plot(cyl_f,sa_lorentz1(D_hi,f_delta,cyl_f)*1e9,'-.','Linewidth',14,'Color',pl_color('cyl_fit'));

yticks([0 0.85 1.7])
xticks([0 50 100 150])

xlim([0 150])
ylim([0 2.25])

xlabel('{\itf}')
ylabel('D({\itf})')


plot_set_4x2_separate;
legend('Analytical','Lorentzian approx.','Location','Southeast')



% cylinder logplot
figure;

loglog(cyl_f,cyl_d_omega*1e9,'-','Linewidth',16,'Color',pl_color('cyl'))
hold on
loglog(cyl_f,sa_lorentz1(D_hi,f_delta,cyl_f)*1e9,'-.','Linewidth',16,'Color',pl_color('cyl_fit'));

xlabel('log {\itf}')
ylabel('log D({\itf})')

xticks([10^0 10^1 10^2])
xlim([10^0 10^2])
ylim([10^-2 1.7])

plot_set_4x2_separate;
legend off;



%1-harmonic plot
figure;

load res_2_30.mat

one_harm_f = f;
one_harm_omega = sa_put_d_omega2zero(ft_ac,f);
[one_harm_omega,one_harm_f] = sa_restrict_freq(one_harm_omega,one_harm_f,0,150);

[D_hi,f_delta] = sa_fit_lorentz(one_harm_omega,one_harm_f);

plot(one_harm_f,one_harm_omega*1e9,'-','Linewidth',16,'Color',pl_color('1-harm'))
hold on
plot(one_harm_f,sa_lorentz1(D_hi,f_delta,one_harm_f)*1e9,'-.','Linewidth',16,'Color',pl_color('1-harm_fit'));


xlim([0 150])
ylim([0 0.2])

yticks([0 0.1 0.2])
xticks([0 50 100 150])

xlabel('{\itf} [Hz]')
ylabel('D({\itf}) [µm^2/ms]')


plot_set_4x2_separate;
legend('Simulated','Lorentzian approx.','Location','Southeast')


%%1-harmonic loglog
figure;

loglog(one_harm_f,one_harm_omega*1e9,'-','Linewidth',16,'Color',pl_color('1-harm'))
hold on
loglog(one_harm_f,sa_lorentz1(D_hi,f_delta,one_harm_f)*1e9,'-.','Linewidth',16,'Color',pl_color('1-harm_fit'));

xticks([10^0 10^1 10^2])

xlabel('log {\itf} [Hz]')
ylabel('log D({\itf}) [µm^2/ms]')

xlim([10^0 10^2])
ylim([10^-2 0.15])

plot_set_4x2_separate;
legend off;




% n-harmonic plot
figure;

n_harm_f = linspace(0,500,1e5);

n_samples = 1e3;

% a = gamrnd(1.5527,1.4827e-06,1,n_samples*1e2)+1e-6;
% T = gamrnd(1.3574,3.6232e-05,1,n_samples*1e2)+10e-6;

a = gamrnd(9.6624,1.8962e-07,1,n_samples*1e2)+1e-6;
T = gamrnd(6.0020,6.7396e-06,1,n_samples*1e2)+10e-6;


a = a(a>1e-6 & a<3e-6); %restrict to what we have tested
T = T(T>10e-6 & T<50e-6);

del = numel(T)-n_samples; %delete randomly the diff so that we get intended number of samples
ind = randperm(numel(T),del);
T(ind) = [];

del = numel(a)-n_samples;
ind = randperm(numel(a),del);
a(ind) = [];

if numel(a) < n_samples || numel(T) < n_samples
    error('Not enough samples')
end

n_harm_d_omega = sa_n_harm_from_1_harm_distrib(a,T,D0,n_harm_f);

[D_hi,f_delta] = sa_fit_lorentz(n_harm_d_omega,n_harm_f);

plot(n_harm_f,n_harm_d_omega*1e9,'Linewidth',16,'Color',pl_color('n-harm'))
hold on
plot(n_harm_f,sa_lorentz1(D_hi,f_delta,n_harm_f)*1e9,'-.','Linewidth',16,'Color',pl_color('n-harm_fit'));



xlim([0 150])
ylim([0 0.2])

xlabel('{\itf}')
ylabel('D({\itf})')

yticks([0 0.1 0.2])
xticks([0 50 100 150])


plot_set_4x2_separate;
legend off;


% n-harmonic loglog
figure;

loglog(n_harm_f,n_harm_d_omega*1e9,'Linewidth',16,'Color',pl_color('n-harm'))
hold on
loglog(n_harm_f,sa_lorentz1(D_hi,f_delta,n_harm_f)*1e9,'-.','Linewidth',16,'Color',pl_color('n-harm_fit'));

xlabel('log {\itf}')
ylabel('log D({\itf})')


xticks([10^0 10^1 10^2])

xlim([10^0 10^2])
ylim([10^-2 0.15])



plot_set_4x2_separate;
legend off;


%stochastic plot
figure;


load('res_stoch_b1.mat');

stoch_f = f;
stoch_d_omega = sa_put_d_omega2zero(ft_ac,f);
[stoch_d_omega,stoch_f] = sa_restrict_freq(stoch_d_omega,stoch_f,0,150);

[D_hi,f_delta] = sa_fit_lorentz(stoch_d_omega,stoch_f);

plot(stoch_f,stoch_d_omega*1e9,'Linewidth',16,'Color',pl_color('stoch'))
hold on
plot(stoch_f,sa_lorentz1(D_hi,f_delta,stoch_f)*1e9,'-.','Linewidth',16,'Color',pl_color('stoch_fit'));



xlim([0 150])
ylim([0 0.2])

yticks([0 0.1 0.2])
xticks([0 50 100 150])

xlabel('{\itf}')
ylabel('D({\itf})')


plot_set_4x2_separate;
legend off;




% stochastic loglog
figure;


loglog(stoch_f,stoch_d_omega*1e9,'Linewidth',16,'Color',pl_color('stoch'))
hold on
loglog(stoch_f,sa_lorentz1(D_hi,f_delta,stoch_f)*1e9,'-.','Linewidth',16,'Color',pl_color('stoch_fit'));


xlabel('log {\itf}')
ylabel('log D({\itf})')
xticks([10^0 10^1 10^2])



xlim([10^0 10^2])
ylim([10^-2 0.15])

plot_set_4x2_separate;
legend off;

