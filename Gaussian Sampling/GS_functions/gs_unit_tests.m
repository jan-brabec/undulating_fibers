function fn = gs_unit_tests(c_ut)
% function fn = gs_unit_tests(c_ut)
%
% Contains unit tests on major adx functions. Uses also f_functions.
% If c_ut is not supplied, the function returns the number of unit tests.
%
% Unit tests:
% 1: If structure is straight (i.e. line) and diffusion encoding positioned along it should return bulk diffusivity
% 2: If structure is straight (i.e. line) and diffusion encoding positioned perpendicular it should return 0 diffusivity
% 3: Gaussian sampling simulation should give the same results as Monte Carlo Simulation.


% n_ut = number of unit tests
n_ut = 3;

if (nargin == 0), fn = n_ut; return; end

switch (c_ut)
    
    case 1 %If structure is straight (i.e. line) and diffusion encoding positioned along it should return bulk diffusivity.
        
        %     tp = tp(1:3);
        addpath('../../Monte Carlo/MC_functions')
        G = MC_G_as_line(20e3,1e-7,pi/2);
        m.x0 = 0;
        m.y0 = 0;
        G_xy = MC_return_G_xy_from_G(G,m);
        
        addpath('../../Analytical/f_functions')
        [t,dt]  = f_gen_time(1, 1e5);
        dt
        [f, df] = f_gen_freq_from_time(t, dt);
        D0 = 1.7e-9;
        cind = 10000:10010;
        parallel = 'parallel_no';
        save_steps = 0;
        y_act = G_xy(:,2);
        dl = 1e-7;
        
%         G_xy = zeros(size(G_xy));
%         G_xy(:,2) = (1:size(G_xy,1)) * dl;
        y_act = G_xy(:,2);
        msd = gs_sim(t,D0,y_act,cind,dl,parallel,save_steps,dt,f);
        
        d_omega = MC_ft_of_ac(MC_get_ac_from_msd(msd,dt),dt);
        d_omega = sa_put_d_omega2zero(d_omega,f);
        clf
        plot(f,d_omega)
        
end



%compare also with results from MC