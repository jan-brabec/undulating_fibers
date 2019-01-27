function Analytical()

% Returns both extra- and intracelular signal S(b) of a yeast for two square pulses
%
% In this step collects basic information on acquisition into m and xps
% Further processing in sa_process(m,xps);
% 1st b=0, 2nd b != 0

addpath('f_functions');

%Model parameters
    r   = 5e-6; %m; radius of cylinder
    S_0 = 1;    %1; floor signal
    f_e = 0;    %1; extracelular fraction

%Other model parameters
    shape = 1;         %'plane' = 1 , 'cylinder' = 2, 'sphere' = 3
    D_i   = 1.7e-9;    %m^2/s; intracelular difussivity
    D_e   = D_i;       %m^2/s; extracelular difussivity
    D_inf = D_i;       %m^2/s; D_int = long-range difussion
    D_0   = D_i;       %m^2/s; D_0  = short-range difussion = bulk-difussivity = D(w=infty), %D_inf/1.32; 
    
    %Parameter vector
    m=[r, S_0, f_e, D_i, D_0, D_e, D_inf, shape];

%Experiment parameters

    t_max    = 2000e-3; %s;         total time of pulse
    t_points = 10001;   %1e7+1; %1; number of time points in the pulse
    
    %Square pulse characteristics
    delta = 25e-3;
    DELTA = 25e-3;
    t0    = 10e-3; %start time of diffusion encoding
    
    
%Experiment definition, xps

    c_exp = 1; %1st experiment
    a = 0; %zero amplitude square pulse
    
    xps.gwf(c_exp).t = f_gen_time(t_max,t_points); %t to xps
    xps.gwf(c_exp).g = f_gen_grad_pulse(xps.gwf(c_exp).t, t0, delta, DELTA, a); %g to xps 
    
    
    c_exp=2; %2nd experiment
    a=0.1;   %non-zero amplitude, others same

    xps.gwf(c_exp).t = f_gen_time(t_max,t_points); %t to xps
    xps.gwf(c_exp).g = f_gen_grad_pulse(xps.gwf(c_exp).t, t0, delta, DELTA, a); %g to xps 
    
    xps.n_exp=length(xps.gwf); %total number of experiments
    
%Run
    xps = sa_process(m,xps);
    
%Signal
    [s, s_i, s_e, D_w] = sa_fit2data(m,xps);

     
%Plot          ----- WHAT DO YOU WISH TO PLOT? 1 or 0 -----
        %             last gwf, last q_t, last ps_qw, D_w, s(b_t), s(b_w), s_e(b_t), s_i(b_t);
    what_to_plot=[1       , 1       , 1         , 1  , 1     , 1     , 1       , 1      ];

    f_plot(m,xps,s,s_i,s_e,D_w,xps.gwf(c_exp).t,xps.gwf(c_exp).w,what_to_plot);
