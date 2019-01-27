function [S,b,ADC,ps_q] = MC_get_signal_from_spectra(g,spectrum,dt,df,f,put_to_zero)
% function [S,b,ADC,ps_q] = MC_get_signal_from_spectra(g,spectrum,mss)
%
%   Returns signal from gradient waveform and MC diffusion spectrum.

if (put_to_zero)
    spectrum = sa_put_d_omega2zero(spectrum,f);
end



for i=1:size(g,1)
    q_t(i,:)  = f_q_t_from_g(g(i,:),dt);
    q_w(i,:)  = f_q_w_from_q_t(q_t(i,:),dt,f);
    ps_q(i,:) = f_ps_q_w_from_q_w(q_w(i,:));
    
   
   
    b(i) = f_b_w_from_ps_q(ps_q(i,:),df);
    
    if b==0
        ADC(i) = 0;
    else
        ADC(i) = sum(ps_q(i,:).*spectrum,2)*df./b(i);
    end
    
    S(i) = exp(-b(i)*ADC(i));     %Check that ps_q is column vector and ft_ac also column vectors on input
    
    if S(i) < 0.4
        warning('Signal below 0.4, Stepisniks approximation may not be valid at high attenuations')
    end
    
end

    warning off;
    p = polyfit(b, log(S), 1);
    warning on;
    ADC = -p(1); %output ADC
end

