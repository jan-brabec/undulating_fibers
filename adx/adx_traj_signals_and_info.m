addpath('../Spectral Analysis/SA_functions')


for c_case = 1:15
    switch c_case
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
    
    gs_spectrum(c_case,:) = sa_put_d_omega2zero(ft_ac,f);
    gs_t  = tp;
    gs_f  = f;
    gs_dt = dt;
    gs_df = df;
    
    amplitude(c_case) = a;
    wavelength(c_case) = T;
    
    x = G_xy(:,1);
    y = G_xy(:,2);
    
    [~, mmuOD(c_case)] = sa_muOD(x,y);
    f_delta_pred_1_harm(c_case) = sa_pred_f_delta_1_harm_muOD(D0,a,T);
    
    grads = f_gen_grad_pulse(gs_t, xps.t0, xps.mde_delta1, xps.mde_capital_delta1, xps.g);
        
    for i=1:5
        [S(i,c_case),b(i,c_case),~,ps_q(c_case,:,i)] = MC_get_signal_from_spectra(grads(i,:),gs_spectrum(c_case,:),gs_dt,gs_df,gs_f,1);
    end
    
    
end
