clf
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

for c_case=1:4
    
    subplot(2,2,c_case)
    
    switch c_case
        case 1
            load res_MC_par_1e6_harmonic_1_10_1e-5.mat
        case 2
            load res_MC_par_1e6_harmonic_1_10_1e-5.mat
        case 3
            load res_MC_par_1e6_harmonic_3_10_1e-5.mat
        case 4
            load res_MC_par_1e6_harmonic_3_10_1e-5.mat
    end
    
    mc_f = mss.ac.f;
    mc_spectrum = sa_put_d_omega2zero(ft_ac_merged(:,2),mc_f);
    mc_dt = mss.ac.dt;
    mc_phi = phi_all;
    
    switch c_case
        case 1
            load 'res_1_10.mat'
            %             title('I.')
            hold on
        case 2
            load 'res_1_10.mat'
            hold on
        case 3
            load 'res_3_10.mat'
            %             title('II.')
            hold on
        case 4
            load 'res_3_10.mat'
            hold on
            
    end
    
    gs_spectrum = sa_put_d_omega2zero(ft_ac,f);
    gs_t  = tp;
    gs_f  = f;
    gs_dt = dt;
    gs_df = df;
    
    if c_case == 1 || c_case == 3
        
        plot(mc_f,mc_spectrum*1e9,'.','Markersize',12,'Color',pl_color('MC'));
        hold on
        plot(gs_f,gs_spectrum*1e9,'Linewidth',4,'Color',pl_color('1-harm'))
        
        xlim([0 150])
        ylim([0 1])
        
        
        plot_set_2x2_in_2x2;
        legend off;
        
        
        if c_case == 1
            xlabel('{\itf} [Hz]')
            ylabel('D({\itf}) [μm^2/ms]')
        end
        
    end
    
    
    
    if c_case == 2 || c_case == 4
        
        for i = 1:4
            [Sp_n(i),bp_n(i)] = MC_get_signal_from_phase_SDE(g_struc.a(i),mc_phi(:,i),mc_dt,g_struc.delta(i),g_struc.DELTA(i));
        end
        [bp, order] = sort(bp_n,'ascend');
        Sp = Sp_n(order);
        
        
        gs_spectrum = sa_put_d_omega2zero(ft_ac,f);
        gs_t  = tp;
        gs_f  = f;
        gs_dt = dt;
        gs_df = df;
        
        grads = f_gen_grad_pulse(gs_t, g_struc.t0, g_struc.delta, g_struc.DELTA, g_struc.a);
        
        for i=1:4
            [Sd_n(i),bd_n(i),~,~] = MC_get_signal_from_spectra(grads(i,:),gs_spectrum,gs_dt,gs_df,gs_f,1);
        end
        [bd, order] = sort(bd_n,'ascend');
        Sd = Sd_n(order);
        
        plot(bd*1e-9,Sd,'--','Linewidth',4,'Color',pl_color('line'))
        hold on
        
        col = pl_color('MC');
        col2 = pl_color('1-harm');
        
        plot(bp_n(1)*1e-9,Sp_n(1),'.','Markersize',60,'Color',pl_color('MC'));
        plot(bd_n(1)*1e-9,Sd_n(1),'.','Markersize',40,'Color',pl_color('1-harm'))
        
        plot(bp_n(2)*1e-9,Sp_n(2),'s','MarkerSize',18,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
        plot(bd_n(2)*1e-9,Sd_n(2),'s','MarkerSize',10,'MarkerEdgeColor',col2, 'MarkerFaceColor',col2)
        
        plot(bp_n(3)*1e-9,Sp_n(3),'p','MarkerSize',18,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
        plot(bd_n(3)*1e-9,Sd_n(3),'p','MarkerSize',10,'MarkerEdgeColor',col2, 'MarkerFaceColor',col2)
        
        plot(bp_n(4)*1e-9,Sp_n(4),'^','MarkerSize',18,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
        plot(bd_n(4)*1e-9,Sd_n(4),'^','MarkerSize',10,'MarkerEdgeColor',col2, 'MarkerFaceColor',col2)
        
        
        ylim([0.85 1])
        xlim([0 3])
        
        plot_set_2x2_in_2x2;
        
        legend off;
        
        if c_case == 2
            hold on
            xlabel('{\itb} [ms/μm^2]')
            ylabel('S')
        end
        
        
    end
    
    
    
end