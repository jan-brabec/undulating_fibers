function [t,dt] = MC_get_t_from_f(f,df)
% function [t,dt] = MC_get_t_from_f(f,df)
%
%   Generates time axis from frequency axis

N     = numel(f);
f_max = max(f);

T  = 1/df;

t = linspace(0,T,N); 
dt = 1/2 *1/f_max;

if abs(t(2)-t(1)) - dt > 1e-10
    error('MC_get_t_from_f does not work')
end

end

