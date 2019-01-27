clf
addpath('../res')
addpath('../SA_functions')

plot_set_2x2;

for c_case=1:4
    
    subplot(2,2,c_case)
    
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
    
    mc_spectra = sa_put_d_omega2zero(ft_ac_merged(:,2),mss.ac.f);
    mc_f = mss.ac.f;
    
    switch c_case
        case 1
            load 'res_1_10.mat'
            title('I.')
            hold on
        case 2
            load 'res_1_50.mat'
            title('II.')
            hold on
        case 3
            load 'res_3_10.mat'
            title('III.')
            hold on
        case 4
            load 'res_3_50.mat'
            title('IV.')
            hold on
    end
    
    gs_spectra = sa_put_d_omega2zero(ft_ac,f);
    gs_f = f;
    
    
    plot(mc_f,mc_spectra*1e9,'-','Linewidth',8,'Color',pl_color('MC'));
    hold on
    plot(gs_f,gs_spectra*1e9,'Linewidth',5,'Color',pl_color('1-harm'))
    
    xlim([0 150])
    ylim([0 1])
    
    
    plot_set_2x2_in_2x2;
    legend off;

    
    if c_case == 1
        xlabel('{\itf} [Hz]')
        ylabel('D({\itf}) [μm^2/ms]')
    end
    
end