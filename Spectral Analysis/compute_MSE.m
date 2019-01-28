clear all


clf
addpath(genpath('../Monte Carlo'))
addpath(genpath('../Analytical'))
addpath(genpath('../Monte Carlo'))
addpath('res')
addpath('SA_functions')

D0 = 1.7e-9;

%Alexander protocol
g_struc.delta    = [12, 15,  5, 13]*1e-3;
g_struc.DELTA    = [80, 77, 87, 20]*1e-3;
g_struc.t0       = [0 ,  0,  0,  0];
g_struc.a        = [58, 46, 57, 60]*1e-3;


type = 'cyl';
switch type
    case 'cyl'
        r = 10e-6;
        
        gs_f = linspace(-5000,5000,1e5+1);
        gs_df = gs_f(2) - gs_f(1);
        [gs_t,gs_dt] = MC_get_t_from_f(gs_f,gs_df);
        
        cyl_d_omega = f_dips_from_r(r, 2, D0, gs_f);
        d_omega = sa_put_d_omega2zero(cyl_d_omega,gs_f);
        
        [D_hi,f_delta] = sa_fit_lorentz(cyl_d_omega,gs_f,0,150);
        lorenz_fit = sa_lorentz1(D_hi,f_delta,gs_f);
        
    case '1-harm'
        load res_2_30.mat
        
        gs_f = f;
        gs_df = gs_f(2) - gs_f(1);
        [gs_t,gs_dt] = MC_get_t_from_f(gs_f,gs_df);
        
        d_omega = sa_put_d_omega2zero(ft_ac,f);
        
        [D_hi,f_delta] = sa_fit_lorentz(d_omega,gs_f,0,150);
        lorenz_fit = sa_lorentz1(D_hi,f_delta,gs_f);
        
        
    case 'n-harm'
        
        gs_f = linspace(-5000,5000,1e5);
        gs_df = gs_f(2) - gs_f(1);
        [gs_t,gs_dt] = MC_get_t_from_f(gs_f,gs_df);

        
        n_samples = 1e3;
        
        a = gamrnd(1.5527,1.4827e-06,1,n_samples*1e2)+1e-6;
        T = gamrnd(1.3574,3.6232e-05,1,n_samples*1e2)+10e-6;
        
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
        
        d_omega = sa_n_harm_from_1_harm_distrib(a,T,D0,gs_f);
        
        [D_hi,f_delta] = sa_fit_lorentz(d_omega,gs_f,0,150);
        lorenz_fit = sa_lorentz1(D_hi,f_delta,gs_f);

        
    case 'stoch'
        load('res_stoch_b1.mat');

        gs_f = f;
        gs_df = gs_f(2) - gs_f(1);
        [gs_t,gs_dt] = MC_get_t_from_f(gs_f,gs_df);

        d_omega = sa_put_d_omega2zero(ft_ac,gs_f);
        [D_hi,f_delta] = sa_fit_lorentz(d_omega,gs_f);
        lorenz_fit = sa_lorentz1(D_hi,f_delta,gs_f);

        
end




grads = f_gen_grad_pulse(gs_t, g_struc.t0, g_struc.delta, g_struc.DELTA, g_struc.a);

for i=1:4
    [Sd_r(i),bd_r(i),~,ps_q_r(i,:)] = MC_get_signal_from_spectra(grads(i,:),d_omega,gs_dt,gs_df,gs_f,1);
    [Sd_fit(i),bd_fit(i),~,ps_q_fit(i,:)] = MC_get_signal_from_spectra(grads(i,:),lorenz_fit,gs_dt,gs_df,gs_f,1);
end
[bd_r, order] = sort(bd_r,'ascend');
Sd_r = Sd_r(order);

[bd_fit, order] = sort(bd_fit,'ascend');
Sd_fit = Sd_fit(order);


subplot(3,1,1)
title('red simulated, blue simplified ')
hold on
plot(bd_r*1e-9,Sd_r,'--','Linewidth',2,'Color','red')
plot(bd_r*1e-9,Sd_r,'o','Linewidth',5,'Color','red')
plot(bd_r*1e-9,Sd_r,'--','Linewidth',2,'Color','red')
plot(bd_r*1e-9,Sd_r,'o','Linewidth',5,'Color','red')

plot(bd_fit*1e-9,Sd_fit,'--','Linewidth',2,'Color','blue')
plot(bd_fit*1e-9,Sd_fit,'o','Linewidth',5,'Color','blue')
plot(bd_fit*1e-9,Sd_fit,'--','Linewidth',2,'Color','blue')
plot(bd_fit*1e-9,Sd_fit,'o','Linewidth',5,'Color','blue')

subplot(3,1,2)
plot(gs_f,d_omega*1e9,'Linewidth',2,'Color','red')
hold on
plot(gs_f,lorenz_fit*1e9,'Linewidth',2,'Color','blue')
MSE = sa_s_MSE(Sd_r,Sd_fit)
ylabel('D(f)')
xlabel('f')
xlim([0 100])
title(MSE);

subplot(3,1,3)
loglog(gs_f,d_omega*1e9,'Linewidth',2,'Color','red')
hold on
loglog(gs_f,lorenz_fit*1e9,'Linewidth',2,'Color','blue')
ylabel('log D(f)')
xlabel('log f')
xlim([0 200])
title(MSE);

legend off;



% SNR = 1/sqrt(MSE)
