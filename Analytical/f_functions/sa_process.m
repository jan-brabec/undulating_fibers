function  xps = sa_process(m,xps)
% function sa_process(m,xps)

% Processes all experiments, stores intermediate steps in xps
% and returns signal as function of b
%
% m(1)=r
% m(2)=S_0
% m(3)=f_e
% m(4)=D_i
% m(5)=D_0


%Process all experiments

for c_exp=1:xps.n_exp
    
    %Time domain
    t  = xps.gwf(c_exp).t;
    dt = xps.gwf(c_exp).t(2) - xps.gwf(c_exp).t(1);
    
    xps.gwf(c_exp).dt=dt; %store dt

    %Frequency domain
    [w, dw] = f_gen_freq_from_time(xps.gwf(c_exp).t, dt);
     xps.gwf(c_exp).w      = w; %store frequency
     xps.gwf(c_exp).dw     = dw;
     
    %q(t),q(w), power of q(w), b(t) and b(w) for each gradient waveform
    
    xps.gwf(c_exp).q_t  = f_q_t_from_g(xps.gwf(c_exp).g,dt);
    xps.gwf(c_exp).q_w  = f_q_w_from_q_t(xps.gwf(c_exp).q_t,dt,xps.gwf(c_exp).w);
    xps.gwf(c_exp).ps_q = f_ps_q_w_from_q_w(xps.gwf(c_exp).q_w);
    xps.gwf(c_exp).b_t  = f_b_t_from_q_t(xps.gwf(c_exp).q_t,dt);
    xps.gwf(c_exp).b_w  = f_b_w_from_ps_q(xps.gwf(c_exp).ps_q,dw);
    
 
end     

%Check that integral over gradient waveforms are zero:       
for c_exp = 1:xps.n_exp
    %Converts structure field and computes sum for each gradient
    g(:,c_exp) = getfield(xps.gwf,{c_exp},'g'); %collect as vector from field
end

f_is_g_zero(g,dt);

%Forget zero frequencies of the spectra
percent = 0;

for c_exp=1:xps.n_exp
    [w, xps.gwf(c_exp).ps_q] = f_forget_zero_freq(xps.gwf(c_exp).w,xps.gwf(c_exp).ps_q,percent);
    xps.gwf(c_exp).w = w;
end