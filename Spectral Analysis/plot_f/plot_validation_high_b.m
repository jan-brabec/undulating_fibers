if (1)
    
    clf;
    
    addpath(genpath('../Monte Carlo'))
    addpath(genpath('../Analytical'))
    addpath('../res')
    addpath('../SA_functions')
    
    
    %Alexander protocol
    g_struc.delta    = [12, 15,  5, 13]*1e-3;
    g_struc.DELTA    = [80, 77, 87, 20]*1e-3;
    g_struc.t0       = [0 ,  0,  0,  0];
    g_struc.a        = [58, 46, 57, 60]*1e-3;
    
    
    if (1)
        
        ampl = linspace(0,600e-3,200);
        grad_wfm = 4;
        
        for c_case = 1:numel(ampl)
            
            load res_MC_par_1e6_harmonic_3_50_1e-5.mat
            
            mc_dt = mss.ac.dt;
            mc_phi = phi_all;
            
            [Sp(c_case),bp(c_case)] = MC_get_signal_from_phase_SDE(ampl(c_case),mc_phi(:,grad_wfm),mc_dt,g_struc.delta(grad_wfm),g_struc.DELTA(grad_wfm));
            
            
            
            load 'res_3_50.mat'
            
            gs_spectrum = sa_put_d_omega2zero(ft_ac,f);
            gs_t  = tp;
            gs_f  = f;
            gs_dt = dt;
            gs_df = df;
            
            norm_grads = f_gen_grad_pulse(gs_t, g_struc.t0, g_struc.delta, g_struc.DELTA, ones(1,numel(g_struc.a)));
            
            [Sd(c_case),bd(c_case),~,~] = MC_get_signal_from_spectra(norm_grads(grad_wfm,:)*ampl(c_case),gs_spectrum,gs_dt,gs_df,gs_f,1);
            
        end
        
        [bd, order] = sort(bd,'ascend');
        Sd = Sd(order);
        
        [bp, order] = sort(bp,'ascend');
        Sp = Sp(order);
        
    end
    
end

plot(bp*1e-9,Sp,'Linewidth',4,'Color',pl_color('MC'));
hold on
plot(bd*1e-9,Sd,'Linewidth',4,'Color',pl_color('1-harm'))

xlabel('{\itb} [ms/μm^2]')
ylabel('S')
legend('Monte Carlo','Gaussian approximation')
plot_set_2x2;


xlim([0 50])
ylim([0 1])




