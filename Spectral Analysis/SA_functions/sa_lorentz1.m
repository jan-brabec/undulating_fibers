function lorentz1 = sa_lorentz1(D_hi,f_delta,f)
% function lorentz1 = sa_lorentz1(D_hi,f_delta,f)
%
% Returns 1-lorentzian

lorentz1 = D_hi * f.^2 ./ (f_delta.^2 + f.^2);

end

