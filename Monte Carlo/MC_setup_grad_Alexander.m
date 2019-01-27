function [do_mc,mss,s] = MC_setup_grad_Alexander()
% function [do_mc,mss,m] = MC_setup_grad_Alexander()
%
%Sets the experiment in a standard way, only the structure is not set.
%Some values may be overwritten later on.

%% Load math functions
addpath('MC_functions');
addpath('../Analytical/tools/frequency');
addpath('../Analytical/msf');

%% MODEL CONSTANTS
s.D0 = 1.7e-9; %bulk diffusivity
s.x0=0; s.y0=0; %Starting positions

%% Resolution
mss.mc.df    = 1;
mss.mc.f_max = 50000; %Hz,  high to get dt = 1e-5
mss.ac.df    = 1;
mss.ac.f_max = 50000; %Hz,  high to get dt = 1e-5

%% MSS
mss.reflectance = 1;   %if particles hit edges they bounce but that should never happen for undulation trajectories
mss.dir         = 2;   %accrue phase in: 1 =  x dir, 2 = y dir


%% type
do_mc = @MC_do_mc_wire_by_msd; % 1D simulation along a straight wire

%% MSS Compute some missing MSS param
mss = MC_process(mss);

%% diffusion step
mss.p.dp   = sqrt(2*s.D0*mss.mc.dt);

%% MSS gradients
mss.g.delta    = [12, 15,  5, 13]*1e-3;
mss.g.DELTA    = [80, 77, 87, 20]*1e-3;
mss.g.t0       = [0 ,  0,  0,  0];    
mss.g.a        = [58, 46, 57, 60]*1e-3;

mss.g.g_norm   = f_gen_grad_pulse(mss.ac.t, mss.g.t0, mss.g.delta, mss.g.DELTA, ones(1, numel(mss.g.delta))); %Square pulse

%% Basic checks on mss and s (not unit tests)
MC_check_consistency(mss,s);
