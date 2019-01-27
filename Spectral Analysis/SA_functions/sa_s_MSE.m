function MSE = sa_s_MSE(s,s_fit)
% function SSE = sa_s_MSE(d_omega,d_omega_fit)
%
%   Computes mean square error of a signal.

MSE = mean((s - s_fit).^2);

end

