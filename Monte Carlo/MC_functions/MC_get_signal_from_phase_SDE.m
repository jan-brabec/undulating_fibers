function [S,b,ADC] = MC_get_signal_from_phase_SDE(g_act,phi,dt,delta,DELTA)
% function [S,b,ADC] = MC_get_signal_from_phase_SDE(g_act,phi,dt,delta,DELTA)
%
%   Returns signal, corresponding b-value and ADC from by phase
%   accumulation. Assuming Stejskal-Tanner pulse sequence.

gamma = f_gamma();
S     = zeros(1, numel(g_act));

for c = 1:numel(g_act)
    phi_act = phi * gamma * g_act(c) * dt;
    S(c) = abs(mean(exp(- 1.0i * phi_act)));
    b(c) = (gamma * delta * g_act(c)).^2 *  (DELTA-delta/3) ;

end

% b-value, Stejskal-Tanner

warning off;
p = polyfit(b, log(S), 1);
warning on;

ADC = -p(1);

end

