function s = adx_1d_fit2data(m, xps)
% function s = adx_1d_fit2data(m, xps)
%
%
% m = [s0 f_ax f_ex f_csf ad_ax ad_ex rd_ex d_csf th ph ax_d]
%
% xps.( bt | mde_delta_1 xps.mde_capital_delta1 )
%


s0  = m(1);
f_1 = m(2);
f_2 = m(3);
f_3 = m(4);
f_4 = 1 - m(2) - m(3) - m(4); % enforce sum(m(2:4)) > 1 somewhere else

ad_1  = m(5); % intra-axon diffusivity
ad_2  = m(6); % extracellular axial diffusivty 
rd_2  = m(7); % extracellular radial diffusivity (link these outside)
d_csf = m(8);

th  = m(9); % theta
ph  = m(10); % phi

a   = m(11); % axon diameter

% cylinder direction
n = [sin(th) * cos(ph)  sin(th) * sin(ph) cos(th)];

rd_1 = adx_rdi(a + eps, ad_1, xps.mde_delta1, xps.mde_capital_delta1);

dt_1 = tm_1x3_to_1x6(repmat(ad_1, numel(rd_1), 1), rd_1, n);
dt_2 = tm_1x3_to_1x6(ad_2, rd_2, n);


s_1 = exp(-sum(xps.bt .* dt_1, 2));         % intra
s_2 = exp(-xps.bt * dt_2');         % extra
s_3 = exp(-xps.b  * d_csf);           % csf      
s_4 = 1;                           % trapped

s = s0 * (...
    f_1 * s_1 + ...
    f_2 * s_2 + ...
    f_3 * s_3 + ...
    f_4 * s_4);
    