function m = adx_1d_data2fit(signal, xps, opt, ind)
% function m = adx_1d_data2fit(signal, xps, opt, ind)

if (nargin < 3), opt = adx_opt; end
if (nargin < 4), ind = ones(size(signal)) > 0; end

unit_to_SI = [max(signal) 1 1 1 1e-9 1e-9 1e-9 1e-9 1 1 1e-6];

    function m = t2m(t) % convert local params to outside format
        
        % define model parameters
        s0          = t(1);
        f_axon      = t(2); 
        f_extra     = t(3);
        f_csf       = t(4);
        
        ad          = t(5);
        d_csf       = t(6); % csf diffusivity
        
        th          = t(7);
        ph          = t(8);
        
        a           = t(9); % diameter
        
        ad_intra = ad;
        ad_extra = ad;
        
        v = f_axon / (f_axon + f_extra);
        rd_extra = ad_extra * (1 - v);
        
        m = [s0 ...
            f_axon f_extra f_csf ...
            ad_intra ad_extra rd_extra d_csf ...
            th ph a] .* unit_to_SI;
    end

    function s = my_1d_fit2data(t,varargin)
        
        m = t2m(t);

        s = adx_1d_fit2data(m, xps);
        
        regterm1 = 0;
        
        s = [s(ind); regterm1 * mean(signal)];
        
    end

% S0, D, vd, f
t_lb      = [0  0 0 0  1.0 2.0  -10 -10   0.];
t_ub      = [2  1 1 1  3.5 3.5  +10 +10   15];

% perform the fit
t = msf_fit(@my_1d_fit2data, [signal(ind);0], t_lb, t_ub, 1, opt.adx.lsq_opts); 

m = t2m(t);



end