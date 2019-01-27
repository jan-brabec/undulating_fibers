function [f, df] = f_gen_freq_from_time(t, dt)
% function [w, dw] = f_gen_freq_from_time(t, dt)
%
% Generates frequency domain from time domain as linspace from -sampling 
% frequency/2 to sampling frequency/2 spanning t_points points.
%
% Returns frequecy vector w and frequecy step dw.


    F_s = 1/dt; %Hz; Sampling frequency, dt = sampling rate
    
    f  = linspace(-F_s, F_s, numel(t)) / 2;
    df = f(2)-f(1); %Hz; frequency step
            
