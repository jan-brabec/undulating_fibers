load ('../Spectral Analysis/res/res_stoch_b4.mat','G_xy')
G_xy_stoch = G_xy;

load res/res_stoch_b4_step_by_step_incomplete.mat

load ('GS_trajectories/1_20_20000.mat','G_xy')
middle = max(G_xy(:,1))/2 + 1.15e-3;



clf;
ds = 10;
ts = t(1:ds:end);
fs = f(1:ds:end);

for i =  1:100:n
    
    subplot(3,1,1)
    plot(fs, d_omega_by_step(:,i)*1e9, 'linewidth', 2);
    hold on
    plot(f, d_omega_by_step_full*1e9, 'linewidth', 2);
    xlabel('f')
    ylabel('D(f) [μm^2/ms]')
    xlim([0 500])
    title(['Diffusion spectra; i = ',num2str(i),''])
    drawnow;
    hold off
    
    subplot(3,1,2)
    msd_by_step = sd_by_step(:,i)/i;
    plot(ts,msd_by_step*1e12, 'linewidth', 2);
    hold on
    plot(ts, sd_by_step(:,n)/n*1e12, 'linewidth', 2);
    xlim([0 0.2])
    title(['msd; i = ',num2str(i),''])
    xlabel('t')
    ylabel('msd(t) [μm^2]')
    drawnow;
    hold off
    
    subplot(3,1,3)
    plot(G_xy_stoch(cind(1:n),1),G_xy_stoch(cind(1:n),2),'linewidth',6)
    hold on;
    plot(G_xy_stoch(cind(1:i),1),G_xy_stoch(cind(1:i),2),'linewidth',6)
    plot(G_xy(1:13000,1)+middle,G_xy(1:13000,2),'Linewidth',2,'Color','green')
    axis equal
    title(['trajectory; cind(1) = ',num2str(cind(1)),': cind(i) = ',num2str(cind(i)),''])
    xlabel('x [μm]')
    ylabel('y [μm]')
    drawnow;
    hold off
end