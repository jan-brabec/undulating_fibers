function q_w = f_q_w_from_q_t(q_t,dt,f)
% function q_w = f_q_w_from_q_t(q_t,dt)
%
% Returns shifted fourier transformed q(w) vector from q(t).
    
    if any(f<0)
        q_w   = fftshift(fft(q_t*dt,[],2),2); %rad/m * s;
    else
        q_w   = fft(q_t*dt,[],2); %rad/m * s;
    end
