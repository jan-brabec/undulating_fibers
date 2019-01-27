function fn = adx_unit_tests(c_ut)
% function fn = adx_unit_tests(c_ut)
%
% Contains unit tests on major adx functions. Uses also f_functions.
% If c_ut is not supplied, the function returns the number of unit tests.
%
% Unit tests:
% 1: Signals from cylinders give back the same estimated diameters.
% 2: No atenuation and infinite SNR should give small estimated diameters.


% n_ut = number of unit tests
n_ut = 2;

if (nargin == 0), fn = n_ut; return; end


switch (c_ut)
    
    case 1 %Signals from cylinders give back the same estimated diameters; assume infinite SNR
        
        adx_setup;
        SNR = 1e20;
        
        d = [1,3,5,8,12,15,20]*1e-6;
        
        for c_case = 1:numel(d)
            t = linspace(0,1,100001);
            dt = t(2) - t(1);
            addpath('../Monte Carlo/MC_functions')
            [f, df] = f_gen_freq_from_time(t, dt);
            grads = f_gen_grad_pulse(t, xps.t0, xps.mde_delta1, xps.mde_capital_delta1, xps.g);
            
            addpath('../Analytical/f_functions');
            cyl_spectrum = f_dips_from_r(d(c_case)/2, 2, 1.7e-9, f);
            
            for i=1:5
                [S(i,c_case),~,~,~] = MC_get_signal_from_spectra(grads(i,:),cyl_spectrum,dt,df,f,1);
            end
        end
        est_d = adx_est_d_from_s(m,xps,S,SNR);
        
        if  max(abs(d - est_d)) > 1e-6
            error('adx_est_d_from_s not returning correct diameter estimates of cylinders')
        end
        
        
    case 2 %No atenuation and infinite SNR should give small estimated diameters, assuming infinite SNR
        adx_setup;
        SNR = 1e20;
        S = ones(5,7);

        est_d = adx_est_d_from_s(m,xps,S,SNR);
        
        if max(est_d) > 2e-6
            error('check discretization in adx_est_d_from_s, no atenuation (S = 1) and inf SNR should give very small diameters')
        end
        
end
end