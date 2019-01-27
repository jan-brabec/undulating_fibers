function D_w = f_dips_from_r(r,shape, D_0, w)
% function D_w = f_dips_from_r(r,shape, D_0, w)
%
% Calculates diffussion spectrum D(w) for a sphere of radii r.

%Assumes that yeasts can be considered as spherically shaped, interconnected,
%permeable or partially opened pores.

%Modified from Lasic 2009: Spectral Characterization of difussion with chemical shift
%resolution: Highly concentrated water-in-oil emulsion
%http://dx.doi.org/10.1016/j.jmr.2009.04.014
%Changed: alpha=0 to obtain only intracelular signal part

%Derivation:
%Stepisnik 2006:
%Spectral characterization of diffusion in porous media by the modulated gradient spin echo with CPMG sequence
%http://dx.doi.org/10.1016/j.jmr.2009.04.014

%Originally from:
%Stepisnik 1992: Time-dependent self-diffusion by NMR spin-echo
%http://dx.doi.org/10.1016/0921-4526(93)90124-O

d = shape;
equation=@(zeta) zeta.*besselj(d/2-1,zeta)-(d-1)*besselj(d/2,zeta);
zeros_wanted=200;
zetas_k = f_find_zeros(equation,zeros_wanted);

a_k = (zetas_k/r).^2;
B_k = (2*(r./zetas_k).^2)  ./  (zetas_k.^2+1-d);

summa = f_sum_numerically(a_k,B_k,w,D_0);

D_w = D_0 * summa; %only intracelular part, "alpha=0"

