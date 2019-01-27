function fn = f_unit_tests(c_ut)
% function fn = MC_unit_tests(c_ut)
%
% Contains unit tests on major MC functions. Uses also f_functions.
% If c_ut is not supplied, the function returns the number of unit tests.
%
% Unit tests:
% 1: Cylinder spectrum same as from the one from the Resolution limit paper.



% n_ut = number of unit tests
n_ut = 1;

if (nargin == 0), fn = n_ut; return; end


switch (c_ut)
    
    case 1 %Cylinder spectrum same as from the one from the Resolution limit paper
        
        %  Figure 1 from:
        %  Nilsson, Markus, et al.
        % "Resolution limit of cylinder diameter estimation by diffusion MRI:
        %  The impact of gradient waveform and orientation dispersion."
        %  NMR in Biomedicine 30.7 (2017): e3711.
        

        d_res_limit  = 3e-6;
        D0_res_limit = 2e-9;
        
        addpath('../../Monte Carlo/MC_functions')
        f_max = 5e3; df = 1;
        [f, ~] = MC_get_f_from_df_f_max(f_max,df);
        d_omega_cyl_res_limit = f_dips_from_r(d_res_limit/2, 2, D0_res_limit, f);
        
        if abs(d_omega_cyl_res_limit(find(f==500))/D0_res_limit - 0.45) > 0.02
            error('f_dips_from_r does not work')
        end
        
end

end



