addpath('SA_functions')

D0 = 1.7e-9;
f = linspace(0,500,1e5);

rep = 1e6;
gama1 = rand(1,rep)*10;
gamT1 = rand(1,rep)*10;
gama2 = rand(1,rep)*3e-6;
gamaT2 = rand(1,rep)*50e-6;

p_h = [];
p_l = [];

D_hi_est = [];
f_delta_est = [];
f_delta_pred = [];
D_hi_pred = [];

c_true = 0;

for c_rep = 1:rep
    
    n_samples = 2e3;
    
    a = gamrnd(gama1(c_rep),gama2(c_rep),1,n_samples)+1e-6; %distrib
    T = gamrnd(gamT1(c_rep),gamaT2(c_rep),1,n_samples)+10e-6;
    
    a = a(a>1e-6 & a<3e-6);
    T = T(T>10e-6 & T<50e-6);
    
    del = abs(numel(a)-numel(T)); %delete randomly the diff so that a and T have same length so that it is well defined distribution of axon-like structures
    if numel(a) < numel(T)
        ind = randperm(numel(T),del);
        T(ind) = [];
    elseif numel(a) > numel(T)
        ind = randperm(numel(a),del);
        a(ind) = [];
    end
    
    %at the ends these are not "gamma distributions" but only part of the
    %gamma distributions
    
    if numel(a)<1000 || numel(T)<1000 || isempty(a) || isempty(T) %do not compute anything if there is less than 1000 samples after restriction
        p_l(c_rep) = NaN;
        p_h(c_rep) = NaN;
        
        D_hi_est(c_rep) = NaN;
        D_hi_pred(c_rep) = NaN;
        
        f_delta_est(c_rep) = NaN;
        f_delta_pred(c_rep) = NaN;
        
        continue;
        
    end

d_omega_avg = sa_n_harm_from_1_harm_distrib(a,T,D0,f);

c_true = c_true + 1;
d_omega_avd_s(c_true,:) = d_omega_avg;

% Estimating
D_hi_est(c_rep) = sa_est_D_hi(d_omega_avg,f);
f_delta_est(c_rep) = sa_est_f_delta(d_omega_avg,f);


% Predicting
[f_delta_pred(c_rep),D_hi_pred(c_rep)] = sa_pred_spectra_n_harm_from_1_harm_distrib(a,T,D0);


%fit of p at low freq.
min_hz_l = 0.001;
max_hz_l = 5;
min_d_omega_l = 0.001;
max_d_omega_l = 0.2;

p_l(c_rep) = sa_fit_p(d_omega_avg,f,min_hz_l,max_hz_l,min_d_omega_l,max_d_omega_l);

%fit lower freq.
min_hz_h = 0.001; %absolute freq.
max_hz_h = 20;
min_d_omega_h = 0; %relative to D_hi
max_d_omega_h = 0.5;

p_h(c_rep) = sa_fit_p(d_omega_avg,f,min_hz_h,max_hz_h,min_d_omega_h,max_d_omega_h);


if (1) %debug
    clf;
    plot(f, d_omega_avg*1e9,'linewidth', 2); hold on;
    plot([0 0] + f_delta_est(c_rep), [0 D_hi_est(c_rep)*1e9], 'linewidth', 2);
    plot([0 0] + f_delta_pred(c_rep), [0 D_hi_est(c_rep)*1e9], 'linewidth', 2);
    plot(f, zeros(size(f)) + D_hi_est(c_rep)*1e9, 'linewidth', 2);
    plot(f, zeros(size(f)) + D_hi_pred(c_rep)*1e9, 'linewidth', 2);
    xlim([0 400]);
    title(['p_l = ' num2str(round(p_l(c_rep),1)) ', p_h = ' num2str(round(p_h(c_rep),1))])
    pause(0.002);
end

c_rep

disp(min(p_l(p_l>0)))
disp(min(p_h(p_h>0)))


end


% [~,ind] = min(p_h)
%
% c_rep = ind;

% gama1(c_rep)
% gama2(c_rep)
%
% gamT1(c_rep)
% gamaT2(c_rep)
