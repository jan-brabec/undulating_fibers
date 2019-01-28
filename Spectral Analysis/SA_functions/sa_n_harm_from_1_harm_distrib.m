function d_omega_avg = sa_n_harm_from_1_harm_distrib(a,T,D0,f)
% function d_omega_avg = sa_n_harm_from_1_harm_distrib(a,T,D0,f)
%
% Return h-harmonic diffusion spectrum from a distribution of 1-harmonic ones
% defined by their amplitudes and wavelengths distributions. The
% distribution needs to have same length.

d_omega_avg = zeros(1,numel(f));
n = 0;

n_samples = numel(a);

for c_exp = 1:n_samples

    d_omega_1_harm = sa_d_omega_from_1_harm_traj(D0,a(c_exp),T(c_exp),f);
    d_omega_avg = d_omega_avg + d_omega_1_harm;
    n = n + 1;
    
end

d_omega_avg = d_omega_avg / n;


end