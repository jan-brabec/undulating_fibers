warning off;
clear all
warning on;


addpath('adx_functions')
addpath(genpath('../Analytical'))
addpath('../../mdm/tools/tensor_maths')
addpath('../../mdm/msf')
addpath('../Spectral Analysis/plot_f')
addpath('../Spectral Analysis/SA_functions')
addpath('../Monte Carlo/MC_functions')
addpath('../Spectral Analysis/res')
addpath('../Gaussian Sampling/GS_functions');

%% Experimental setup definition
xps.t0                 = [0 0  0  0  0 ]';
xps.g                  = [0 58 46 57 60]' * 1e-3;
xps.mde_delta1         = [12 12 15 5 13]' * 1e-3;
xps.mde_capital_delta1 = [80 80 77 87 20]' * 1e-3;
xps.td = xps.mde_capital_delta1 - xps.mde_delta1 / 3;
xps.b = msf_const_gamma().^2 * xps.mde_delta1.^2 .* xps.g.^2 .* (xps.td);
xps.bt = tm_1x3_to_1x6( xps.b, zeros(size(xps.b)), [1 0 0]);

%% Model definition
s0    = 1;      % background signal
f_ax  = 1;      % fraction axon
f_ex  = 0;      % fraction extracelular
f_csf = 0;      % fraction csd
ad_ax = 1.7e-9; % diff coef ax
ad_ex = ad_ax;  % diff coef extracel
rd_ex = 0.3e-9; % radial diffusivity extra
d_csf = 3e-9;   % csf diffusivity
th    = 0;      % theta
ph    = 0;      % phi

m = [s0 f_ax f_ex f_csf ad_ax ad_ex rd_ex d_csf th ph];
