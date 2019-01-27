marker_size = 50;
std_size = 10;


for aj = 1:2
    
    figure;
    
    
    switch aj
        case 1 %amplitude vs est_d
            
            for i=1:numel(amplitude)
                
                if i == 1
                    plot(-10, -10,'.','MarkerSize', marker_size,'Color',pl_color('1-harm'));
                    hold on
                end
                
                
                if wavelength(i) ~= 30e-6 && wavelength(i) ~= 10e-6
                    col = pl_color('1-harm');
                    plot(amplitude(i)*1e6, d_est(i)*1e6,'.','MarkerSize', marker_size,'Color',col,'HandleVisibility','off');
                end
                
                if wavelength(i) == 10e-6
                    col = pl_color('cyl_fit');
                    plot(amplitude(i)*1e6, d_est(i)*1e6,'s','MarkerSize',15,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
                end
                
                if wavelength(i) == 30e-6
                    col = pl_color('cyl_fit');
                    plot(amplitude(i)*1e6, d_est(i)*1e6,'.','MarkerSize',marker_size,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
                end
                
                
                
                
                hold on
                xlabel('{\ita} [μm]')
                plot_set_2x2;
                xlim([0.5 3.5])
                xticks([1,2,3])
                
                legend('{\it\lambda} = 20, 40, 50 μm','{\it\lambda} = 10 μm','{\it\lambda} = 30 μm','Location','southeast')
% legend off
                
            end
            
            
        case 2 %pred d vs est d
            
            plot([0 20],[0 20],'--','Color',pl_color('line'),'Linewidth',5,'Handlevisibility','off')
            hold on
            
            for i=1:numel(mmuOD)
                if i == 1
                    col = pl_color('1-harm');
                    plot(d_pred(i)*1e6, d_est(i)*1e6,'p','MarkerSize',18,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
                    
                elseif i == 5
                    col = pl_color('1-harm');
                    plot(d_pred(i)*1e6, d_est(i)*1e6,'s','MarkerSize', 16,'MarkerEdgeColor',col, 'MarkerFaceColor',col);
                    
                else
                    col = pl_color('1-harm');
                    plot(d_pred(i)*1e6, d_est(i)*1e6,'.','MarkerSize', marker_size,'Color',col,'Handlevisibility','off');
                    
                end
                
%                 title(f_delta_pred_1_harm(i))
                hold on
                xlabel('Predicted {\itd} = {\itk} \cdot {\ita} \cdot μOD^{-1/4} [μm]')
                
                plot_set_2x2;
                legend('{\itf_{\Delta}} = 92 Hz; panel C',...
                    '{\itf_{\Delta}} = 5 Hz;   panel D',...
                    'Location','southeast');
                xticks([0,4,8,12,16])
                xlim([0 16])
%                 pause
            end
    end
    
    
    
    
    
    yticks([0,4,8,12,16])
    ylabel('Estimated {\itd} [μm] ')
    ylim([0 16])
    
    % ax.XColor = '[0.5 0.5 0.5]'; % Red
    % ax.YColor = '[0.5 0.5 0.5]'; % Blue
    % set(gca,'xtick',[])
    % set(gca,'ytick',[])
    %     ax = gca;
    %     set(ax,'linewidth',4)
    %     set(ax,'defaultfigurecolor','white')
    
    
end

