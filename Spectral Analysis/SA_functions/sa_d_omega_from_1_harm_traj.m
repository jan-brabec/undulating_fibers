function d_omega = sa_d_omega_from_1_harm_traj(D0,a,T,f)
% function d_omega = sa_d_omega_from_1_harm_traj(D0,a,T,f)
%
% Returns diffusion spectrum of a 1-harmonic based on a Lorentzian model


pnts = 5000;
dl = 1e-7;

[x,y] = sa_1_harm_trajectory(a,T,pnts,dl,'1_revolution_from_left');

f_delta = sa_pred_f_delta_1_harm(D0,a,T);
D_hi    = sa_pred_D_hi(x,y,D0);

d_omega = sa_lorentz1(D_hi,f_delta,f);


if (0) %debug
    clf;
    plot(f,d_omega*1e9, 'k-', 'linewidth', 2)
    hold on
    plot([0 0] + f_delta, [0 D_hi*1e9], 'linewidth', 2);
    plot(f, zeros(size(f)) + D_hi*1e9, 'linewidth', 2);
    ylabel('D(f) [µm^2/ms]')
    xlabel('f [Hz]')
    xlim([0 100])
    pause;
end


end

