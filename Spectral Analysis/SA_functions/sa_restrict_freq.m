function [d_omega,f] = sa_restrict_freq(d_omega,f,f0,f_max)
% function [d_omega,f] = sa_restrict_freq(d_omega,f,f0,f_max)
%
%   Restricts frequencies from f0 to f_max

[~,ind] = min(abs(f-f0));
d_omega = d_omega(ind:end);
f       = f(ind:end);

[~,ind] = min(abs(f-f_max));
d_omega = d_omega(1:ind);
f       = f(1:ind);

end

