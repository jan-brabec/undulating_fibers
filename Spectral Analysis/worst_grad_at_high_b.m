clear all
clc


max_amplitude = 1000e-3;
b_where_to_comp = 50e9;

clf;

addpath(genpath('../Monte Carlo'))
addpath(genpath('../Analytical'))
addpath('res')
addpath('SA_functions')


%Alexander protocol
g_struc.delta    = [12, 15,  5, 13]*1e-3;
g_struc.DELTA    = [80, 77, 87, 20]*1e-3;
g_struc.t0       = [0 ,  0,  0,  0];
g_struc.a        = [58, 46, 57, 60]*1e-3;


for c_case=1:4
    
    switch c_case
        case 1
            load res_MC_par_1e6_harmonic_1_10.mat
        case 2
            load res_MC_par_1e6_harmonic_1_50.mat
        case 3
            load res_MC_par_1e6_harmonic_3_10.mat
        case 4
            load res_MC_par_1e6_harmonic_3_50.mat
    end
    mc_dt = mss.ac.dt;
    mc_phi = phi_all;
    
    switch c_case
        case 1
            load 'res_1_10.mat'
        case 2
            load 'res_1_50.mat'
        case 3
            load 'res_3_10.mat'
        case 4
            load 'res_3_50.mat'
    end
    
    gs_spectrum = sa_put_d_omega2zero(ft_ac,f);
    gs_t  = tp;
    gs_f  = f;
    gs_dt = dt;
    gs_df = df;
    
    ampl = linspace(0,max_amplitude,200);
    
    for j = 1:4
        
        
        grad_wfm = j;
        for c_exp = 1:numel(ampl)
            norm_grads = f_gen_grad_pulse(gs_t, g_struc.t0, g_struc.delta, g_struc.DELTA, ones(1,numel(g_struc.a)));
            
            
            [Sp(c_exp),bp(c_exp)] = MC_get_signal_from_phase_SDE(ampl(c_exp),mc_phi(:,grad_wfm),mc_dt,g_struc.delta(grad_wfm),g_struc.DELTA(grad_wfm));
            [Sd(c_exp),bd(c_exp),~,~] = MC_get_signal_from_spectra(norm_grads(grad_wfm,:)*ampl(c_exp),gs_spectrum,gs_dt,gs_df,gs_f,1);
            
        end
        
        [bd, order] = sort(bd,'ascend');
        Sd = Sd(order);
        
        [bp, order] = sort(bp,'ascend');
        Sp = Sp(order);
        
        [~,idx]=min(abs(bd - b_where_to_comp));
        difference(c_case,j) = abs(Sp(idx)-Sd(idx));
        atenuations(c_case,j) = Sd(idx);
        
        clf
        drawnow;
        title(dif(c_case,j))
        hold on
        plot(bp*1e-9,Sp,'Linewidth',4,'Color',pl_color('MC'));
        hold on
        plot(bd*1e-9,Sd,'Linewidth',4,'Color',pl_color('1-harm'))
        xlabel('{\itb} [ms/μm^2]')
        ylabel('S')
        legend('Monte Carlo','Gaussian approximation')
        hold on
        xlim([0 10])
        ylim([0 1])
        
        a*1e6
        T*1e6
        j
        %             if c_case == 3 && j == 4
        %                 pause
        %             end
        
        
    end
    
end

difference
atenuations







