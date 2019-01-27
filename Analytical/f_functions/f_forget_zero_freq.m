function [w, ps_q] = f_forget_zero_freq(w,ps_q,percent)
% function [w, ps_q] = f_forget_zero_freq(w,ps_q)
%
% Cuts certain percentage on both sides of frequency that do not contribute to the
% signal (are zero or almost zero) from frequency domain and q vector.
%
% Main purpose is to speed up computation of diffusion spectra and signal
% but does not speed up computation of q(w).

lim=round(percent/100*numel(ps_q));%cut certain % on both sides from the end of the spectrum

if percent > 0
    ps_q(1:lim)=[];
    ps_q(numel(ps_q)-lim:numel(ps_q))=[];

    w(1:lim)=[];
    w(numel(w)-lim:numel(w))=[];
end

