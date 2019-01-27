function [msd,sd_by_step,d_omega_by_step] = gs_sim(t,D0,y_act,cind,dl,parallel,save_steps,dt,f)
% function msd = gs_sim(t,D0,y_act,cind,dl,parallel)
%
% Gaussian sampling simulation.

addpath('../Spectral Analysis/SA_functions')

sampling_density = 1e-7; %use 1e-9 if velocity autocorrelation function is used directly
up_to = 4; %4 sigma

if strcmp(parallel,'parallel_yes')
    parforArg = Inf;
else
    parforArg = 0;
end

sd  = zeros(size(t));
msd = zeros(size(t));

if (save_steps)
    ds = 50;
    sd_by_step = zeros(numel(t(1:ds:end)),numel(cind));
    d_omega_by_step_full = zeros(size(t));
    d_omega_by_step = zeros(numel(t(1:ds:end)),numel(cind));
end

n = 0;
tic
for c = cind %step along the trajectory
    parfor (c_t = 1:numel(t), parforArg) %step along time for a specific position along the trajectory
        
        sigma = sqrt( 2 * D0 * t(c_t) );
        d = linspace(-up_to*sigma, up_to*sigma, round(2*up_to*sigma/sampling_density));
        
        w = normpdf( d, 0, sigma);
        w = w / sum(w(:));
        
        ind = c + d / dl;
        y = ...
            (1 - ind + floor(ind))' .* y_act( floor(ind)) + ...
            (ind - floor(ind))' .* y_act( floor(ind) + 1);
        
        sd(c_t) = sd(c_t) + sum(w' .* (y - y_act(c)).^2);
    end
    n = n + 1;
    
    if (save_steps)
        sd_by_step(:,n) = sd(1:ds:end);
        d_omega_by_step_full = MC_ft_of_ac(MC_get_ac_from_msd(sd/n,dt),dt);
        d_omega_by_step_full = sa_put_d_omega2zero(d_omega_by_step_full,f);
        d_omega_by_step(:,n) = d_omega_by_step_full(1:ds:end);
        
        save tmp.mat
    end

    fprintf('%d out of %d, ind = %d \n',n,numel(cind),c);
end

msd = sd / n;
msd(1) = 0;
toc

delete(gcp('nocreate'))
end

