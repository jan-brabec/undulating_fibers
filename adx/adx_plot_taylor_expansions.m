c_case = [1,15];

for c_case = c_case
    
    
    
    figure;
    for i=1:5
        
        %fix 4th grad for plot
        ps_q(:,find(f==0),:) = ps_q(:,find(f==0)+1,:);
        
        f0 = find(gs_f == 0);
        mx = max(max(max(ps_q(:,:,:))));
        lmx= max(ps_q(c_case,:,i))+eps;
        
        if c_case == 1
            times = 0.2;
        else
            times = 0.2;
        end
        h(1) = area(gs_f,ps_q(c_case,:,i)/lmx * times,'HandleVisibility','off','FaceAlpha',.3,'EdgeAlpha',.3);
        h(1).FaceColor = [0.7 0.7 0.7];
        
        hold on;
        
    end
    
    df_cyl_est = f_dips_from_r(d_est(c_case)/2,2, D0, gs_f);
    f0 = find(gs_f==0);
    
    df_cyl_pred = f_dips_from_r(d_pred(c_case)/2,2, D0, gs_f);
    D0 = 1.7e-9;
    D_hi(c_case) = mmuOD(c_case)*D0;
    
    kf_trajectory = D_hi(c_case)/f_delta_pred_1_harm(c_case)^2 * gs_f.^2;
    
    f_delta_cylinder(c_case) = 2.35*D0/d_est(c_case)^2;
    kf_cylinder = D0/f_delta_cylinder(c_case)^2 * gs_f.^2;
    
    plot2 = plot(gs_f,df_cyl_est*1e9,'Linewidth',4,'Color',pl_color('cyl_fit'));
    hold on
    plot1 = plot(gs_f,gs_spectrum(c_case,:)*1e9,'Linewidth',4,'Color',pl_color('1-harm'));
    plot4 = plot(gs_f,kf_cylinder*1e9,'--','Linewidth',4,'Color',pl_color('cyl_fit'));
    plot3 = plot(gs_f,kf_trajectory*1e9,'--','Linewidth',4,'Color',pl_color('1-harm'));
    plot5 = plot(0,0,'Color','white');
    
    
    if c_case == 1
        legend([plot1 plot3 plot2 plot4 plot5],{'Simulated fiber', 'Approximation','Analytical cylinder', 'Approximation',' '},'Location','southeast')
    else
        legend([plot1 plot3 plot2 plot4 plot5],{'Simulated fiber', 'Approximation','Analytical cylinder', 'Approximation',' '},'Location','southeast')
    end
    
    if c_case == 1
        xlabel('{\itf} [Hz]')
        ylabel('D({\itf}) [μm^2/ms]; |q^2({\itf})| [a.u]')
    end
    plot_set_2x2;
    
    
    if c_case == 1 || 5
        xlim([0 100])
        xticks([0 50 100 150])
        ylim([0 0.2])
        yticks([0 0.1 0.2])
        
    end
    
end

