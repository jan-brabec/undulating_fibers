function [t, dt] = f_gen_time(t_max, t_points)
% function [t, dt] = f_gen_time(t_max, t_points)
%
% Generates time when gradient waveform is applied as a vector from 0 to
% t_max of t_points equally spaced time points.
%
% Returns time vector t and timestep dt.

    t  = linspace(0,t_max,t_points);
    dt = t(2) - t(1);
            
