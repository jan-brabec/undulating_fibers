clf
clear all
addpath('../res')
addpath('../SA_functions')
addpath(genpath('../../Monte Carlo'))
addpath(genpath('../../Analytical'))

%Alexander protocol
g_struc.delta    = [12, 15,  5, 13]*1e-3;
g_struc.DELTA    = [80, 77, 87, 20]*1e-3;
g_struc.t0       = [0 ,  0,  0,  0];
g_struc.a        = [58, 46, 57, 60]*1e-3;

plot_set_2x2;

ha = tight_subplot(3,3,[.001 .001],[.01 .01],[.01 .01]);

for c_case=1:9
    
    subplot(3,3,c_case)
    
    switch c_case
        case 1
            load res_MC_par_1e6_harmonic_1_10_1e-5.mat
        case 3
            load res_MC_par_1e6_harmonic_1_50_1e-5.mat
        case 7
            load res_MC_par_1e6_harmonic_3_10_1e-5.mat
        case 9
            load res_MC_par_1e6_harmonic_3_50_1e-5.mat
    end
    
    mc_f = mss.ac.f;
    mc_spectrum = sa_put_d_omega2zero(ft_ac_merged(:,2),mc_f);
    mc_dt = mss.ac.dt;
    mc_phi = phi_all;
    
    switch c_case
        case 1
            load 'res_1_10.mat'
        case 2 
            load 'res_1_30.mat'
        case 3
            load 'res_1_50.mat'
        case 4
            load 'res_2_10.mat'
        case 5
            load 'res_2_30.mat'
        case 6
            load 'res_2_50.mat'
        case 7
            load 'res_3_10.mat'
        case 8
            load 'res_3_30.mat'
        case 9
            load 'res_3_50.mat'
            
    end
    
    gs_spectrum = sa_put_d_omega2zero(ft_ac,f);
    gs_t  = tp;
    gs_f  = f;
    gs_dt = dt;
    gs_df = df;
    
    if c_case == 1 || c_case == 3 || c_case == 7 || c_case == 9
        plot(mc_f,mc_spectrum*1e9,'.','Markersize',15,'Color',pl_color('MC'));
    end
        hold on
        plot(gs_f,gs_spectrum*1e9,'Linewidth',4,'Color',pl_color('1-harm'))
        
        xlim([0 150])
        ylim([0 1])
        
        
        plot_set_2x2_in_2x2;
        legend off;
        
        if c_case >= 1 && c_case <= 6
            xticks([0 50 100 150])
            xticklabels({'','','',''})
        end
        
        if c_case == 2 || c_case == 3 || c_case == 5 || c_case == 6 || c_case == 8 || c_case == 9
            yticks([0 0.5 1])
            yticklabels({'','',''})
        end        
        
        if c_case == 1 
            ylabel('D({\itf}) [µm^2/ms]')
        elseif c_case == 4 || c_case == 7
            ylabel('D({\itf})')
        end
        
        
        if c_case == 7 
            xlabel('{\itf} [Hz]')
        elseif c_case == 8 || c_case == 9
            xlabel('{\itf}')
        end
        
        
end