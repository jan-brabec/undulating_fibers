clf
addpath('../res')
addpath('../SA_functions')
addpath('plotSpread')

for c_rep=1 : 15 %harmonic
    
    switch c_rep
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
    
    %fit of p at low freq.
    min_hz_l = 0.001;
    max_hz_l = 5;
    min_d_omega_l = 0.001;
    max_d_omega_l = 0.2;
    
    p_l_1_harm(c_rep) = sa_fit_p(d_omega,f,min_hz_l,max_hz_l,min_d_omega_l,max_d_omega_l);
    
    %fit lower freq.
    min_hz_h = 0.001; %absolute freq.
    max_hz_h = 20;
    min_d_omega_h = 0; %relative to D_hi
    max_d_omega_h = 0.5;
    
    p_h_1_harm(c_rep) = sa_fit_p(d_omega,f,min_hz_h,max_hz_h,min_d_omega_h,max_d_omega_h);
    
    
    if (0) %debugging
        clf;
        subplot(1,2,1)
        plot(f,d_omega*1e9, 'k+', 'linewidth', 2)
        hold on
        %             plot(f,ind)
        %             plot([0 0] + w, [0 1], 'linewidth', 2);
        %             plot(f, zeros(size(f)) + D_inf*1e9, 'linewidth', 2);
        xlim([0 f(find(ind==1,1,'last'))])
        
        subplot(1,2,2)
        loglog(f,d_omega, 'k+', 'linewidth', 2)
        hold on
        loglog(f, D_inf * abs(1 - 1 ./ (1 + (f / w).^p_harmonic(plr))), 'r--', 'linewidth', 2);
        title(['p = ' num2str(pv(end-1),2)]);
        xlim([0 150]);
        
        pause;
    end
end

clearvars -except p_l_1_harm p_h_1_harm

load('res_probe_n_harm.mat','p_h','p_l')

p_l_n_harm = p_l;
p_h_n_harm = p_h;



if(1)
    clf;
    for c_rep=1:7
        
        
        switch c_rep
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
        
        %fit of p at low freq.
        min_hz_l = 0.001;
        max_hz_l = 5;
        min_d_omega_l = 0.001;
        max_d_omega_l = 0.2;
        
        p_l_stoch(c_rep) = sa_fit_p(d_omega,f,min_hz_l,max_hz_l,min_d_omega_l,max_d_omega_l);
        
        %fit lower freq.
        min_hz_h = 1; %absolute freq.
        max_hz_h = 20;
        min_d_omega_h = 0; %relative to D_hi
        max_d_omega_h = 0.5;
        
        p_h_stoch(c_rep) = sa_fit_p(d_omega,f,min_hz_h,max_hz_h,min_d_omega_h,max_d_omega_h);
        
        
        if (0) %debug
            clf;
            subplot(1,2,1)
            plot(f,d_omega*1e9, 'k.', 'linewidth', 2)
            hold on
            %             plot(f,ind)
            plot([0 0] + w, [0 1], 'linewidth', 2);
            %             plot(f, zeros(size(f)) + D_inf*1e9, 'linewidth', 2);
            xlim([0 f(find(ind==1,1,'last'))])
            
            subplot(1,2,2)
            loglog(f,d_omega, 'k-', 'linewidth', 2)
            hold on
            loglog(f, D_inf * abs(1 - 1 ./ (1 + (f / w).^p_stochastic(plr))), 'r--', 'linewidth', 2);
            title(['p = ' num2str(pv(end-1),2)]);
            xlim([0 150]);
            
            pause;
        end
        
        
        
    end
end

% figure
ind = randi(100,[1,100]);
ind2 = find(p_h_n_harm < 1.8 & p_h_n_harm > 1.7);
ind2 = ind2(randi(numel(ind2),[1,10]));
p_h_n_harm2plot = [p_h_n_harm(ind), p_h_n_harm(ind2), min(p_h_n_harm) max(p_h_n_harm)];
p_h_n_harm2plot = p_h_n_harm2plot(~isnan(p_h_n_harm2plot));

plotSpread({p_h_1_harm, p_h_n_harm2plot, p_h_stoch},...
    'xNames',{'1-harmonic','n-harmonic','stochastic'},...
    'spreadWidth',0.2,'yLabel','{\itp}_{fit}','distributionColors',{'black','black','black'})

hold on;
plot_set_2x2;
xlim([0.5 3.5])
legend off
xtickangle(15)
legend off;