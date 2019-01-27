function fn = MC_unit_tests(c_ut)
% function fn = MC_unit_tests(c_ut)
%
% Contains unit tests on major MC functions. Uses also f_functions.
% If c_ut is not supplied, the function returns the number of unit tests.
%
% Unit tests:
% 1: Freqency and time axis interchanged.
% 2: Restriction function.
% 3: Checks that analytical signal is same as MC signal when analytical diffusion spectrum is feeded in 1D for plane.
% 4: Checks that analytical diffusion spectrum overlaps with the MC spectrum.
% 5: Check that analytical diffusion spectrum overlaps with the MC spectrum but for structure that is 90 degrees turned.
% 6: Diffusion spectrum of without restrictions is a flat line at D0.
% 7: Checks the function MC_gen_v_from_x(x,x_prev,dt).
% 8: Diffusion spectrum and mean square displacement for free diffussion,
%    using functions.
% 9: Return random structure back and forth.
% 10: MC_p_init_uniform_over_length should  give a uniform distribution.
% 11: MC_get_v_from_x should give velocity.
% 12: MC_apply_const_restrictions should not allow partiles to escape.



addpath(genpath('../../Analytical/f_functions'))
addpath(genpath('../../Analytical/methods/spectrum_analysis'))


% n_ut = number of unit tests
n_ut = 12;

if (nargin == 0), fn = n_ut; return; end


switch (c_ut)
    
    case 1 %Freqency and time axis interchanged
        t_i=linspace(0,1,10);
        dt_i=t_i(2)-t_i(1);
        
        [f, df] = f_gen_freq_from_time(t_i, dt_i);
        [t_f,dt_f] = MC_get_t_from_f(f,df);
        
        if t_f ~= t_i | dt_f ~= dt_i
            error('f_gen_freq_from_time and/or MC_gen_t_from_f not working')
        end
        
    case 2 %Restriction function
        r=10;
        x1=ones(1,100)*20;
        x2=ones(1,100)*-20;
        x=cat(2,x1,x2); %positions of 200 particles all outside of r
        reflectance=0;
        x = MC_apply_const_restrictions(x,-r,r,reflectance);
        
        if any(x>r)==1 | any(x<-r)==1
            error('f_apply_const_restrictions not working')
        end
        
    case 3 %Checks that analytical signal is same as MC signal when analytical diffusion spectrum is feeded in 1D for plane.
        
        %Square pulse characteristics
        delta    = 50e-3;
        DELTA    = 50e-3;
        t0       = 0e-3;   %start time of diffusion encoding
        t_max    = 100e-3; %s; total time of pulse
        t_points = 1e5+1;
        t        = f_gen_time(t_max,t_points);
        
        c_exp = 1; %1st experiment
        a     = 0; %zero amplitude square pulse
        xps.gwf(c_exp).t = f_gen_time(t_max,t_points); %t to xps
        xps.gwf(c_exp).g = f_gen_grad_pulse(xps.gwf(c_exp).t, t0, delta, DELTA, a); %g to xps
        
        c_exp = 2; %2nd experiment
        a     = 100e-3; %non-zero amplitude, others same
        xps.gwf(c_exp).t = f_gen_time(t_max,t_points); %t to xps
        xps.gwf(c_exp).g = f_gen_grad_pulse(xps.gwf(c_exp).t, t0, delta, DELTA, a); %g to xps
        
        xps.n_exp = length(xps.gwf); %total number of experiments
        
        g_matrix(1,:) = xps.gwf(1).g;
        g_matrix(2,:) = xps.gwf(2).g;
        
        %m   = [r   , S_0, f_e, D_i   ,    D_0,    D_e,  D_inf, dimension];
        m   = [5e-6,   1,   0, 1.7e-9, 1.7e-9, 1.7e-9, 1.7e-9,         1];
        xps = sa_process(m,xps);
        [~, s_i, ~, ~] = sa_fit2data(m,xps);
        
        for c_exp=1:xps.n_exp
            b_t(c_exp) =xps.gwf(c_exp).b_t;
            b_w(c_exp) =xps.gwf(c_exp).b_t;
            mss.ac.f   =xps.gwf(c_exp).w;
        end
        
        r     = m(1);
        D_0   = m(5);
        shape = m(8);
        direction = shape;
        ft_ac(:,direction) = f_dips_from_r(r,shape, D_0, xps.gwf(1).w);
        mss.ac.dt = xps.gwf(1).dt;
        mss.ac.df = mss.ac.f(2) - mss.ac.f(1);
        mss.ac.ft = xps.gwf(1).dw;
        
        [S,b,~] = MC_get_signal_from_spectra(g_matrix,ft_ac(:,1)',mss.ac.dt,mss.ac.df,mss.ac.f,0);
        
        figure;
        plot(b_w*1e-9,s_i,'color','red')
        hold on;
        plot(b*1e-9,S,'color','blue')
        title('If two curves overlap analytical signal and MC when analytical diffusion spectrum is feeded are for 1D plane same');
        
        %Allow for 1% error in both and propagate
        e2=0.01*b;
        e1=0.01*b_w;
        if any(abs(b-b_w)>sqrt(abs(e2.^2-e1.^2))) %propagate error
            error('Relative error in b-values is greater than 8 % in each')
        end
        
        %Allow for 1% error in both and propagate
        e2=0.01*s_i;
        e1=0.01*S;
        if any(abs(s_i-S)>sqrt(abs(e2.^2-e1.^2)))
            error('Relative error in signal values is greater than 8 % in each')
        end
        
        
        
        
        
    case 4 %Checks that analytical diffusion spectrum overlaps with the MC spectrum
        clear m clear mss
        %mss
        mss.mc.df = 1;
        mss.mc.f_max = 1000; %Hz
        mss.ac.df = 1;
        mss.ac.f_max = 1000; %Hz
        mss.particles = 1e4;     %Number of particles
        
        %m
        do_mc = @MC_do_mc_wire_by_msd;
        m.D0 = 1.7e-9; %bulk diffusivity
        m.reflectance=1;
        L=5e-6; %min is 350e-6 for proper initial distribution
        m.struc = MC_G_as_line(1,L,0); %(# of segments, length, angle)
        m.x0=0; m.y0=0;
        
        %Process
        mss = MC_process(mss);
        
        %gradient def
        delta = mss.ac.t_max/2;
        DELTA = mss.ac.t_max/2;
        t0    = 0; %start time of diffusion encoding
        a = 1;
        [c index] = min(abs(mss.ac.t-delta));
        mss.g.n_delta=index;%find(mss.ac.t-delta<eps & mss.ac.t-delta>eps); %pos of delta
        
        mss.g.g_norm   = f_gen_grad_pulse(mss.ac.t, t0, delta, DELTA, a);
        mss.g.g_act    = linspace(0,100e-3,2);         %actual strength
        mss.g.g_matrix = MC_get_g_from_g_act_g_norm(mss.g.g_act,mss.g.g_norm); %Collect all gradients into matrix
        
        mss.dir = 1; %accrue phase in: 1 =  x dir, 2 = y dir
        mss.ratio = 1;
        mss.plot_simul = 0;
        mss.p.dp   = sqrt(2*m.D0*mss.mc.dt);
        mss.reflectance = 1;
        
        disp('make sure that MC_p_init_uniform_over_length(mss.particles,s.struc,mss.ratio) is chosen in the mc_sim')
        msd_out  = MC_sim(do_mc,mss,m);
        ac_out   = MC_get_ac_from_msd(msd_out,mss.ac.dt);
        ft_ac    = MC_ft_of_ac(ac_out,mss.ac.dt);
        addpath('../../Spectral Analysis/SA_functions')
        ft_ac    = sa_put_d_omega2zero(ft_ac,mss.ac.f);
        
        figure;
        plot(mss.ac.f,ft_ac)
        hold on;
        ft_ac_analytical=f_dips_from_r(L/2,1, m.D0, mss.ac.f);
        plot(mss.ac.f,ft_ac_analytical);
        title('Analytical and MC diffusion spectrum for 1D plane, if overlap => ok');
        
        
    case 5 %Check the same but for structure that is 90 degrees turned
        clear m clear mss
        %mss
        mss.mc.df = 1;
        mss.mc.f_max = 1000; %Hz
        mss.ac.df = 1;
        mss.ac.f_max = 1000; %Hz
        mss.particles = 1e4;     %Number of particles
        
        %m
        do_mc = @MC_do_mc_wire_by_msd;
        m.D0 = 1.7e-9; %bulk diffusivity
        m.reflectance=1;
        L=5e-6; %min is 350e-6 for proper initial distribution
        m.struc=MC_G_as_line(1,L,pi/2); %(# of segments, length, angle)
        m.x0=0; m.y0=0;
        
        %Process
        mss = MC_process(mss);
        
        %gradient def
        delta= mss.ac.t_max/2;
        DELTA= mss.ac.t_max/2;
        t0   = 0; %start time of diffusion encoding
        a = 1;
        [c index] = min(abs(mss.ac.t-delta));
        mss.g.n_delta=index;%find(mss.ac.t-delta<eps & mss.ac.t-delta>eps); %pos of delta
        
        mss.g.g_norm = f_gen_grad_pulse(mss.ac.t, t0, delta, DELTA, a);
        mss.g.g_act = linspace(0,100e-3,2);         %actual strength
        mss.g.g_matrix = MC_get_g_from_g_act_g_norm(mss.g.g_act,mss.g.g_norm); %Collect all gradients into matrix
        
        mss.dir = 1; %accrue phase in: 1 =  x dir, 2 = y dir
        mss.ratio = 1;
        mss.plot_simul = 0;
        mss.p.dp   = sqrt(2*m.D0*mss.mc.dt);
        mss.reflectance = 1;
        disp('make sure that MC_p_init_uniform_over_length(mss.particles,s.struc,mss.ratio) is chosen in the mc_sim')

        msd_out  = MC_sim(do_mc,mss,m);
        ac_out   = MC_get_ac_from_msd(msd_out,mss.ac.dt);
        ft_ac    = MC_ft_of_ac(ac_out,mss.ac.dt);
        addpath('../../Spectral Analysis/SA_functions')
        ft_ac    = sa_put_d_omega2zero(ft_ac(:,2),mss.ac.f);
        
        
        figure;
        plot(mss.ac.f,ft_ac)
        hold on;
        ft_ac_analytical=f_dips_from_r(L/2,1, m.D0, mss.ac.f);
        plot(mss.ac.f,ft_ac_analytical);
        title('Analytical and MC diffusion spectrum for 1D plane, if overlap => ok');
        
        
        
        
    case 6 %Diffusion spectrum of without restrictions is a flat line at D0.
        steps = 10000;
        particles = 10000;
        
        t=linspace(0,1,steps);
        dt=t(2)-t(1);
        f = f_gen_freq_from_time(t, dt);
        
        D0=1.7e-9;
        dx=sqrt(2*D0*dt);
        x = rand(1,particles); % init position
        ac = zeros(1,steps);
        
        for c=1:steps
            x_prev = x;
            x = x + randn(1,size(x,2))*dx;
            
            if c==1
                v0=MC_get_v_from_x(x,x_prev,dt);
            end
            
            v=MC_get_v_from_x(x,x_prev,dt);
            ac(c)=MC_get_ac_from_v(v,v0);
            
        end
        ac=ac';
        ac(:,2)=zeros(particles,1);
        ft_ac = MC_ft_of_ac(ac,dt);
        
        p = polyfit(f,ft_ac(:,1)',1);
        
        if p(2)-D0>1e-10 || abs(p(1))>1e-10
            error('Diffusion spectrum of free diffusion is not a line at D0')
        end
        
        
        
        
    case 7 %Checks the function MC_gen_v_from_x(x,x_prev,dt)
        x_prev=zeros(100,1);
        x     =ones(100,1)*rand(1);
        dt    =rand(1);
        
        v = MC_get_v_from_x(x,x_prev,dt);
        
        if any(v ~= x/dt)==1
            error('MC_gen_v_from_x does not work')
        end
        
       
        
    case 8 %Define random structure, large offset from [0,0], iterate 200 times to check that it never contains [x,0] or [0,y]
        %Structure and its segment should be small so a lot of possibilities to ran away and a lot
        %of changing of particle positions between segments
        
        for i=1:200
            m.x0=1000;
            m.y0=1000;
            l_default     = 1e-06;
            Angle_default = 0;
            rnd_angle     = true;
            rnd_length    = true;
            angle_type    = 'uniform'; %'gaussian' or  'uniform' or 'gaussian_memory', not used
            sigma = pi/4;
            a = 10; %shape gamma param
            b = 3e-7;%scale gamma param
            m.struc=MC_G_as_random(rnd_angle,rnd_length,l_default,Angle_default,angle_type,a,b,sigma);
            
            ratio = 1;
            mss.particles=1e4;
            [p,mss.p.p_start,mss.p.p_end]   = MC_p_init_uniform_over_length(mss.particles,m.struc,ratio); %ratio 1 => uniformly in whole struc,0 => at one point in the middle
            
            
            [x,G_xy] = MC_p2xy(p,m.struc,m.x0,m.y0);
            
            if any(x(:,1))==0 || any(x(:,2))==0
                error('MC_p2xy returns some zero particle positions despite high offset from origin');
            end
        end
        
        if (1)
            figure;
            plot(G_xy(:,1),G_xy(:,2),'LineWidth',6,'Color','b'); %plot structure
            hold on;
            plot(x(:,1),x(:,2),'.','Color','r'); %plot particle positions
            str=sprintf('Structure and last particle positions, total length = %.2e',sum((m.struc(1,:))));
            title(str);
            hold on;
            legend('Structure','Particles, final pos')
        end
        
        
    case 9
        %Return random structure back and forth
        
        m.x0=500;
        m.y0=400;
        l_default     = 1e-03;
        Angle_default = 0;
        rnd_angle     = true;
        rnd_length    = true;
        angle_type    = 'uniform'; %'gaussian' or  'uniform' or 'gaussian_memory', not used
        sigma = pi/4;
        a = 10; %shape gamma param
        b = 3e-7;%scale gamma param
        
        
        G = MC_G_as_random(rnd_angle,rnd_length,l_default,Angle_default,angle_type,a,b,sigma);
        G_xy = MC_return_G_xy_from_G(G,m);
        G_ret = MC_return_G_from_G_xy(G_xy,m);
        
        mat = G_ret(:,:)-G(:,:)>1e-8;
        if any(mat(:)==1)
            error('MC_return_G_xy_from_G and/or MC_return_G_from_G_xy do not work');
        end
        
        
        
    case 10
        m = 1e8;
        G = [1e-6;0];
        ratio = 1;
        
        [p,p_start,p_end] = MC_p_init_uniform_over_length(m,G,ratio);
        
        if mean(p)-1e-6/2 > 1e-9 | var(p)>1e-11
            error('MC_p_init_uniform_over_length does not give a uniform distribution')
        end
        
        
    case 11
        
        x = 10;
        x_prev = 0;
        dt = 10;
        
        v = MC_get_v_from_x(x,x_prev,dt);
        
        if v ~= 1
            error('MC_get_v_from_x does not work')
        end
        
        
    case 12
        a = 4;
        b = 6;
        p = rand([1e6,1])*10;
        reflectance = 0;
        p = MC_apply_const_restrictions(p,a,b,reflectance);
        
        if ~isempty(find(p>b)) | ~isempty(find(p<a))
            error('MC_apply_const_restrictions does not work')
        end
        
        
        
end

end

