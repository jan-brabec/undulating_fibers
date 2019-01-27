function opt = adx_opt(opt)
% function opt = adx_opt(opt)
%
% Makes sure that all needed fields in the options structure are present

opt.adx.present = 1;

opt.adx = msf_ensure_field(opt.adx, 'tmp', 1); 
opt.adx = msf_ensure_field(opt.adx, 'lsq_opts', ...
    optimoptions('lsqcurvefit', 'display', 'off'));
opt.adx = msf_ensure_field(opt.adx, 'do_plot', 0);