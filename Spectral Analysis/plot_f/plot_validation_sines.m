x = linspace(0,50e-6,1000);

ha = tight_subplot(3,3,[.3 .05],[.05 .05],[.05 .05]);
clf

for c_case = 1:9
    
    switch c_case
        case 1
            a = 1e-6; T = 10e-6;
        case 2
            a = 1e-6; T = 30e-6;
        case 3
            a = 1e-6; T = 50e-6;
        case 4
            a = 2e-6; T = 10e-6;
        case 5
            a = 2e-6; T = 30e-6;
        case 6
            a = 2e-6; T = 50e-6;
        case 7
            a = 3e-6; T = 10e-6;
        case 8
            a = 3e-6; T = 30e-6;
        case 9
            a = 3e-6; T = 50e-6;
    end
    
    sines = a*1.5*sin(2*pi*x/T);
    
    subplot(3,3,c_case)
    plot(x*1e6,sines*1e6,'Linewidth',4,'Color',pl_color('1-harm'));

    
    xticklabels({'0',' ',' ',' ',' ','50'})
    yticks([-3 3])
    yticklabels({'',''})
    
    if c_case == 1
        ylabel('{\ity} [µm]')
        xlabel('{\itx} [µm]');
        xticks([0 10 20 30 40 50])
        yticks([-3 3])
        yticklabels({'-3','3'})
    end
    
    
    plot_set_2x2_in_2x2;
    legend off
    ax.TickLength = [0.04 0.02];
    axis equal
    axis off
        xlim([0 100])
%     ylim([-3 3])
    
end