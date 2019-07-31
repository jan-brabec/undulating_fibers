addpath('../Monte Carlo/MC_functions')
addpath('../Spectral Analysis/SA_functions')
addpath('../Analytical/f_functions')
addpath('../Spectral Analysis/plot_f')
addpath('res')
addpath('../Spectral Analysis/res')


clf
ha = tight_subplot(1,5,[.005 .005],[.005 .005],[.005 .005]);


for c_exp = 1:5
    
    subplot(1,5,c_exp)
    switch c_exp
        case 1 % 1 - 50
            load dl_0_02_each_60_a_1_L_50_1_mil_d_1.mat
            load('res_1_50.mat','ft_ac','f')
        case 2  %1 - 50
            load dl_0_02_each_60_a_1_L_50_1_mil_d_2.mat
            load('res_1_50.mat','ft_ac','f')
        case 3  %1 - 50
            load dl_0_02_each_60_a_1_L_50_1_mil_d_3.mat
            load('res_1_50.mat','ft_ac','f')
        case 4 %1 - 50
            load dl_0_1_each_60_a_1_L_50_3_mil_d_5.mat
            load('res_1_50.mat','ft_ac','f')
        case 5 %1 - 50
            load dl_0_1_each_60_a_1_L_50_3_mil_d_10.mat
            load('res_1_50.mat','ft_ac','f')
    end
    
    %Process part
    msd(end+1) = msd(end);
    time(end+1) = time(end) + msd_dt;
    d_omega = MC_ft_of_ac(MC_get_ac_from_msd(msd,msd_dt),msd_dt);
    [f2,df] = f_gen_freq_from_time(time, time(2)-time(1));
    
    d_omega = sa_put_d_omega2zero(d_omega,f2);
    d_omega_straigt_cyl = f_dips_from_r(diameter/2,2, geometry.D(1), f2);
    d_omega_fiber = sa_put_d_omega2zero(ft_ac,f);
    
    
    
    
    % Plot part
    line_width = 4;
    marker_size = 20;
    
    p_und_cyl = plot(f2,d_omega*1e9,'.','Markersize',marker_size,'Color',pl_color('MC'));
    hold on
    p_straight_cyl = plot(f2,d_omega_straigt_cyl*1e9,':','Linewidth',line_width,'Color',pl_color('cyl'));
    p_fiber = plot(f, d_omega_fiber*1e9,'Linewidth',line_width,'Color',pl_color('1-harm'));
    
    xlim([0 50])
    ylim([0 0.04])
    yticks([0 0.02 0.04])
    xticks([0 25 50])
    
    hold on
    ax = gca;
    ax.FontSize = 30;
    ax.TickLength = [0.04 0.02];
    set(ax,'tickdir','out');
    set(ax,'linewidth',2);
    
    box off
    legend boxoff
    
    if c_exp == 1
        legend([p_und_cyl p_straight_cyl p_fiber],'Undulating cylinder','Straight cylinder','Undulating fiber')
        xlabel('{\itf} [Hz]')
        ylabel('D({\itf}) [µm^2/ms]')
        
    else
        legend off;
        xlabel('{\itf}')
    end
    
    
end