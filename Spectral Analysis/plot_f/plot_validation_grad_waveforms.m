addpath(genpath('../../Analytical'))

%Alexander protocol
g_struc.delta    = [12, 15,  5, 13]*1e-3;
g_struc.DELTA    = [80, 77, 87, 20]*1e-3;
g_struc.t0       = [0 ,  0,  0,  0];
g_struc.a        = [58, 46, 57, 60]*1e-3;


t = linspace(-0.005,10,1e5+1);
dt = t(2) - t(1);

grads   = f_gen_grad_pulse(t, g_struc.t0, g_struc.delta, g_struc.DELTA, g_struc.a);
grads(:,1) = [0;0;0;0];

[ps_q,f] = f_ps_q_from_g(grads,t);


for c_case = 1:size(ps_q,1)
    ps_q(c_case,:) = ps_q(c_case,:)./trapz(f,ps_q(c_case,:));
end


if (1)
    figure
    plot(f,ps_q(1:3,:),'Linewidth',4,'Color',pl_color('1-harm'))
    hold on
    plot(f,ps_q(4,:),'-','Linewidth',4) %,'Color','[0.8510    0.3255    0.0980]'
    plot(f,ps_q(4,:),'-','Linewidth',4,'Color',pl_color('extra')) %
    
    xlim([0 50])
    ylabel('|q({\itf})|^2 [a.u.]')
    xlabel('{\itf} [Hz]');
    yticks([0 0.1])
    
    plot_set_2x2;
    legend off;
    
end


if (1)
    
    for c_case = 1:4
        
        figure;
        
        if c_case == 4
            color = pl_color('extra');
        else
            color = pl_color('1-harm');
        end
        
        plot(t*1e3,grads(c_case,:)*1e3,'Linewidth',4,'Color','red')
        xlim([-5 100])
        ylim([-100 100])
        
        if c_case == 1
            ylabel('|g({\itt})| [mT/m]')
            xlabel('{\itt} [ms]');
        else
            set(gca,'Xticklabel',[])
            set(gca,'Yticklabel',[])
        end
        
        set(gcf,  'Position', [1 1 245 238]);
        set(gca,  'Position', [0.432 0.346 0.473 0.579]);
        
        plot_set_2x2_in_2x2;
        legend off
        ax.TickLength = [0.04 0.02];
        
        
    end
end



