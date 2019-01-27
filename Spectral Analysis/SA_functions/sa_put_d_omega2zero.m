function d_omega = sa_put_d_omega2zero(d_omega,f)
% function d_omega = sa_put_d_omega2zero(d_omega,f)
%
% Puts zero frequency to zero.

[~,ind] = min(abs(f));
d_omega = d_omega - d_omega(ind);

end

