addpath(genpath('../../Analytical'))
addpath('../SA_functions')
addpath('../res')

if (1)
    
    D0 = 1.7e-9;
    
    %1-harmonic plot
    figure;
    
    load res_2_30.mat
    
    one_harm_f = f;
    one_harm_omega = sa_put_d_omega2zero(ft_ac,f);
    [one_harm_omega,one_harm_f] = sa_restrict_freq(one_harm_omega,one_harm_f,0,150);
    
    D_hi_est_1_harm = sa_est_D_hi(one_harm_omega,one_harm_f);
    one_harm_omega = one_harm_omega / D_hi_est_1_harm;
    
    
    % n-harmonic plot
    n_harm_f = linspace(0,500,1e5);
    n_samples = 1e3;
    
    a = gamrnd(9.6624,1.8962e-07,1,n_samples*1e2)+1e-6;
    T = gamrnd(6.0020,6.7396e-06,1,n_samples*1e2)+10e-6;
    
%     a = gamrnd(2.4015,7.9895e-07,1,n_samples*1e2)+1e-6;
%     T = gamrnd(1.2419,4.1495e-05,1,n_samples*1e2)+10e-6;
%     
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
    
    D_hi_est_n_harm = sa_est_D_hi(n_harm_d_omega,n_harm_f);
    n_harm_d_omega = n_harm_d_omega / D_hi_est_n_harm;
    
    %stochastic plot
    load('res_stoch_b1.mat');
    
    stoch_f = f;
    stoch_d_omega = sa_put_d_omega2zero(ft_ac,f);
    [stoch_d_omega,stoch_f] = sa_restrict_freq(stoch_d_omega,stoch_f,0,150);
    
    D_hi_est_stoch = sa_est_D_hi(stoch_d_omega,stoch_f);
    stoch_d_omega = stoch_d_omega / D_hi_est_stoch;
end



%normal plot
plot(one_harm_f,one_harm_omega,'-','Linewidth',4,'Color',pl_color('1-harm'))
hold on;
plot(n_harm_f,n_harm_d_omega,'--','Linewidth',4,'Color',pl_color('n-harm'))
plot(stoch_f,stoch_d_omega,':','Linewidth',4,'Color',pl_color('stoch'))

legend('1-harmonic','n-harmonic','stochastic','Location','southeast')

xlim([0 50])
xticks([0 25 50])

ylim([0 1.1])

xlabel('{\itf} [Hz]')
ylabel('D({\itf}) [a.u.]')

plot_set_2x2;


%log-log plot
figure;

loglog(one_harm_f,one_harm_omega,'-','Linewidth',4,'Color',pl_color('1-harm'))
hold on
loglog(n_harm_f,n_harm_d_omega,'--','Linewidth',4,'Color',pl_color('n-harm'))
loglog(stoch_f,stoch_d_omega,':','Linewidth',4,'Color',pl_color('stoch'))

f = linspace(0,1000,1e4);

loglog(f,10 * abs(1 - 1 ./ (1 + (f / 100).^1)), '-.', 'linewidth', 4,'Color', pl_color('cyl_fit'));
loglog(f(1:180), 20 * abs(1 - 1 ./ (1 + (f(1:180) /100).^2)), '--', 'linewidth', 4,'Color', pl_color('cyl_fit'));

xlabel('log {\itf} [Hz]')
ylabel('log D({\itf}) [a.u]')

legend('1-harmonic','n-harmonic','stochastic','{\itf}^1','{\itf}^2','Location','southeast')

xticks([10^0 10^1 10^2])
xlim([10^0 10^2])
ylim([10^-2 1])

plot_set_2x2;
