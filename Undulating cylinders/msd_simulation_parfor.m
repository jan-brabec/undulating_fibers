if (1)
    
    addpath('undulating_cyl_source')
    
    diameter = 0.5e-6
    step_length = 0.1e-6
    particles_per_worker = 250000
    
    
    
    clear geometry sequence;
    
    geometry.f              = [0.7 0.3];
    geometry.diameter       = diameter;
    geometry.step_length    = step_length;
    
    geometry.tau            = [0 Inf ];
    geometry.D              = [2 2] * 1e-9;
    
    geometry.n_particles    = particles_per_worker;
    geometry.n_intra        = geometry.n_particles;
    geometry.n_extra        = 0; %geometry.n_particles;
    
    geometry.global_T1      = inf;
    
    geometry.draw_geo       = 'draw_ondulating_axon_v2';
    geometry.ond_period     = 50e-6;
    geometry.ond_amplitude  = 1e-6;
    
    dt = geometry.step_length^2 / 4 / geometry.D(1);
    
    % Define sequence (just bogus here to fool prep_compartment_sim)
    sequence.td          = 20000*dt;
    sequence.delta       = zeros(size(sequence.td)) + 10000*dt;
    sequence.b           = [0 0.25 0.5 0.75 1] * 1e9;
    sequence.g_dir       = [1 0 0];
    
    [s,geo] = prep_compartment_sim(sequence,geometry);
    
    s.S0 = 1;
    
    % start the simulations
    pos = int32(geo.pos_i - 1); % positions
    g       = uint8(geo.g);     % geometry, i.e. definition of compartments
    
    % Prepare for the c-program
    T       = double(geo.T);    % transition matrix
    dt_s    = double(s.scaled_delta_t); % time increments in the different compartments
    com     = double(zeros(geo.n_dim, geo.n_particles)); % centre-of-masses
    safeprimes_filename = getenv('SIMULATOR_PRIMES');
    debug = 0;
    
    % Make every step to be 120 times
    each = 120;
    msd_dt = each * s.delta_t(1);
    
    gwf     = [0 msd_dt / s.delta_t(1) * dt_s];
    
    % Do the simulation
    pos_tmp = pos;
    num_workers = 4;
    
    msd_i = zeros(3, 10000, num_workers);
    time = (1:size(msd_i,2)) * msd_dt;
    
    fprintf('Sim: particles per worker: %d t_max = %d, msd_dt = %s, num_workers = %d.\n',particles_per_worker,max(time),msd_dt,num_workers);

    parpool(num_workers);
    tic
    parfor K = 1:num_workers
        
        if K == 1
            disp(K)
            msd_i(:,:,K) = ond_msd(time,g,T,dt_s,gwf,com,safeprimes_filename,debug,pos);
        end
        
        if K == 2
            disp(K)
            msd_i(:,:,K) = ond_msd(time,g,T,dt_s,gwf,com,safeprimes_filename,debug,pos);
        end
        
        if K == 3
            disp(K)
            msd_i(:,:,K) = ond_msd(time,g,T,dt_s,gwf,com,safeprimes_filename,debug,pos);
        end
        
        if K == 4
            disp(K)
            msd_i(:,:,K) = ond_msd(time,g,T,dt_s,gwf,com,safeprimes_filename,debug,pos);
        end
    end
    toc
    
    delete(gcp('nocreate'))
     
end

if (1) %sum up msd and choose only transversial to work with
    clear msd_avg
    msd_avg(:,:) = mean(msd_i,3);
    msd = msd_avg(1,:) * geo.step_length^2;
end

if (0) %free diffusion unit test
    msd_theory = 2 * geo.D(1) * time;
    plot(time, msd2, time, msd_theory)
end


if (1)
    addpath('../Monte Carlo/MC_functions')
    addpath('../Spectral Analysis/SA_functions')
    addpath('../Analytical/f_functions')
    
    d_omega = MC_ft_of_ac(MC_get_ac_from_msd(msd,msd_dt),msd_dt);
    [f2,df] = f_gen_freq_from_time(time, time(2)-time(1));
    d_omega = sa_put_d_omega2zero(d_omega,f2);
    clf
    
    plot(f2,d_omega)
    hold on
end



if (1) %trajectory with a, lambda
    load('../undulating_structures/Spectral Analysis/res/res_1_50.mat','f','ft_ac')
    plot(f, sa_put_d_omega2zero(ft_ac,f),'Color','blue');
    
end


if (1) %cylinder with diameter
    d_omega_theory = f_dips_from_r(diameter/2,2, geometry.D(1), f);
    hold on
    plot(f,d_omega_theory,'Color','red');
end

if (1)
    d_sum = d_omega_theory + sa_put_d_omega2zero(ft_ac,f);
    plot(f,d_sum,'Color','black')
    
    legend('Monte Carlo','undulating wire','straight cylinder','sum of wire and cyl')
    xlim([0 300])
end


save tmp_dl_0_1_each_120_a_1_L_50_1_mil_d_0_5.mat