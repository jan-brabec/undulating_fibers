function [msd,phi,x,mss] = MC_sim(do_mc,mss,s)
% function [msd,phi,x,mss] = MC_ac_sim(do_mc,mss,m,plot_simul,ratio)
%
% Runs Monte Carlo simulations and returns computed parameters.
% Input parameters are structure type, acquistition and model parameters.

%Init positions as:

% [p,mss.p.p_start,mss.p.p_end]    = MC_p_init_gauss_middle_length_G(s.x0,s.y0,mss.particles,s.struc); % starts in the middle
% [p,mss.p.p_start,mss.p.p_end]    = MC_p_init_uniform_length_G(s.x0,s.y0,mss.particles,s.struc); Starts uniformly over whole structure
% [p,mss.p.p_start,mss.p.p_end]    = MC_p_init_uniform_over_length(mss.particles,s.struc,mss.ratio); %ratio 1 => uniformly in whole struc,0 => at one point in the middle
 [p,mss.p.p_start,mss.p.p_end]     = MC_p_init_uniform_over_spec_pos(mss.particles,s.struc,mss.pos_init); %start at certain positions given in mss.pos_init

%Init variables
x_init    = zeros(mss.particles,2);
x_act     = zeros(mss.particles,2);
phi       = zeros(mss.particles,size(mss.g.g_norm,1));
msd       = zeros(mss.ac.n,2);

if (mss.plot_simul) %Init simulation figure
    h = figure(1);
    if ishandle(h)
        close(h)
    end
    h=figure(1);
    set(h,'WindowStyle', 'docked');
end


%Simulation
for c=1:mss.ac.n
    [p, x] = do_mc(p,mss,s);
    if c==1
        x_init = x;
    end
    if c>=1
        x_act=x;
    end
    
    
    msd(c,:)       = MC_get_msd_from_x(x_act,x_init);
    phi            = MC_accrue_phase(phi,x_act,mss.g.g_norm,mss.dir,c);
    
    if (mss.plot_simul)
        plot(s.struc_xy(:,1),s.struc_xy(:,2),'LineWidth',6,'Color','b');
        hold on;
        plot(x(:,1),x(:,2),'.','Color','r');
        hold on;
        drawnow;
        axis equal
        hold off;
    end
    
    
%     disp(c);
    
    
end

end