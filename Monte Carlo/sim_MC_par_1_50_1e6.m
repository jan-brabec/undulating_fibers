%Runs Monte Carlo simulation in a 1D sine wave and returns and plots:

% Mean square displacement
% Autocorrelation function from msd and from direct computation of velocities
% Diffusion spectrum from both autocorrelation functions
% (Total) signal by phase accruation and from diffusion spectrum
% Structure with last positions of particles


%%
[do_mc,mss,s] = MC_setup_grad_Alexander;

num_workers = 5
mss.particles   = 1e6  /   num_workers; %Number of particles

fprintf('\nResolution of ac: f_max =  %.0f Hz, df = %.1e, t_max =  %.0f s, dt = %.1e, n = %.0f\n',  mss.ac.f_max, mss.ac.df, mss.ac.t_max, mss.ac.dt, mss.ac.n);
fprintf('Resolution of mc: f_max =  %.0f Hz, df = %.1e, t_max =  %.0f s, dt = %.1e, n = %.0f\n', mss.mc.f_max, mss.mc.df, mss.mc.t_max, mss.mc.dt, mss.mc.n);
fprintf('Spatial resolution is: dp = %.1e.\n\n', mss.p.dp)

%%
%Init
global hits
hits = 0;

%%
%Compute
tic

what_to_sim = 'a_1_labda_50';

switch what_to_sim
    case 'a_1_labda_10'
        load '../Gaussian Sampling/GS_trajectories/1_10_20000.mat'
        mss.pos_init = [9.8312e-04, 9.9405e-04]; %sine 1 10
    case 'a_1_labda_50'
        load '../Gaussian Sampling/GS_trajectories/1_50_20000.mat'
        mss.pos_init = [9.537e-04, 10.039e-04]; %sine 1 50
    case 'a_3_labda_10'
        load '../Gaussian Sampling/GS_trajectories/3_10_20000.mat'
        mss.pos_init = [9.63e-04, 9.792e-04];   %sine 3 10
    case 'a_3_labda_50'
        load '../Gaussian Sampling/GS_trajectories/3_50_20000.mat'
        mss.pos_init = [9.570e-04, 10.089e-04]; %sine 3 50
end
        
% Others
% mss.pos_init = [9.245e-04, 9.9051e-04]; %sine 10 50
% mss.pos_init = [9.632e-04, 10.0508e-04]; %sine 10 10
% mss.pos_init = [9.570e-04, 10.089e-04]; %sine 3 50
% mss.pos_init = [9.63e-04, 9.792e-04];   %sine 3 10
%mss.pos_init(1) = 9.245e-04; mss.pos_init(2) = 9.9051e-04; clf; mss.x0=0; mss.y0=0; G_xy = MC_return_G_xy_from_G(s.struc,mss); plot(G_xy(:,1),G_xy(:,2)); [p,p_start,p_end] = MC_p_init_uniform_over_spec_pos(1e4,s.struc,mss.pos_init); [xy,~] = MC_p2xy(p,s.struc,0,0); hold on; plot(xy(:,1),xy(:,2),'.');


s.struc = MC_return_G_from_G_xy(G_xy,s);
s.struc_xy = G_xy;

mss.plot_simul = 0;
parpool(num_workers)

parfor K = 1:num_workers
    if K == 1
        [msd_out(:,:,K),phi_out(:,:,K),x_out(:,:,K),~]  = MC_sim(do_mc,mss,s);
    end
    
    if K == 2
        [msd_out(:,:,K),phi_out(:,:,K),x_out(:,:,K),~]  = MC_sim(do_mc,mss,s);
    end
    
    if K == 3
        [msd_out(:,:,K),phi_out(:,:,K),x_out(:,:,K),~]  = MC_sim(do_mc,mss,s);
    end
    
    if K == 4
        [msd_out(:,:,K),phi_out(:,:,K),x_out(:,:,K),~]  = MC_sim(do_mc,mss,s);
    end    
    
    if K == 5
        [msd_out(:,:,K),phi_out(:,:,K),x_out(:,:,K),~]  = MC_sim(do_mc,mss,s);
    end      
end

for c_num = 1:num_workers
    ac_out(:,:,c_num)   = MC_get_ac_from_msd(msd_out(:,:,c_num),mss.ac.dt);
    ft_ac(:,:,c_num)    = MC_ft_of_ac(ac_out(:,:,c_num),mss.ac.dt);
end

ac_merged = mean(ac_out,3);
ft_ac_merged = mean(ft_ac,3);

phi_merged = [phi_out(:,:,1); phi_out(:,:,2); phi_out(:,:,3); phi_out(:,:,4); phi_out(:,:,5)]; %adjust acc to the number of if statements



fprintf('\nBasis %.0f: Ratio particles hit the wall/total number of particles per run = %.0f procent.\n', j,  (hits/(mss.particles))*100);

toc

save res_MC_par_1e6_harmonic_1_50.mat


delete(gcp('nocreate'))

