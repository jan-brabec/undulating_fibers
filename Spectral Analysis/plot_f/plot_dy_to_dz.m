addpath(genpath('../../Analytical'))
addpath('../SA_functions')
addpath('../res')


clear all
for c_exp = 1:15
    
    
    switch c_exp
        case 1
            load 'res_1_10.mat'
        case 2
            load 'res_1_20.mat'
        case 3
            load 'res_1_30.mat'
        case 4
            load 'res_1_40.mat'
        case 5
            load 'res_1_50.mat'
            
            
        case 6
            load 'res_2_10.mat'
        case 7
            load 'res_2_20.mat'
        case 8
            load 'res_2_30.mat'
        case 9
            load 'res_2_40.mat'
        case 10
            load 'res_2_50.mat'
            
        case 11
            load 'res_3_10.mat'
        case 12
            load 'res_3_20.mat'
        case 13
            load 'res_3_30.mat'
        case 14
            load 'res_3_40.mat'
        case 15
            load 'res_3_50.mat'
    end
    
    left_1_harm(c_exp)  = mean(dy.^2 ./ dz.^2)
    right_1_harm(c_exp) = mean(abs(dy)).^2 / mean(abs(dz)).^2
    
    
end


for c_case = 1:7
    
    
    switch c_case
        case 1
            load res_stoch_2_longer_time_lower_dt_until_10s.mat;
        case 2
            load res_stoch_3_longer_time_lower_dt_until_10s.mat;
        case 3
            load res_stoch_4_longer_time_lower_dt_until_10s.mat;
        case 4
            load('res_stoch_b1.mat');
        case 5
            load('res_stoch_b2.mat');
        case 6
            load('res_stoch_b3.mat');
        case 7
            load('res_stoch_b4.mat');
    end

    left_stoch(c_case)  = mean(dy.^2 ./ dz.^2)
    right_stoch(c_case) = mean(abs(dy)).^2 / mean(abs(dz)).^2

end



clf


h1 = plot([0 0.6],[0 0.6],'--','Color',pl_color('line'),'Linewidth',10,'HandleVisibility','off');
hold on
h2 = plot(right_1_harm,left_1_harm,'.','Markersize',80,'color','black');
hold on
h3 = plot(right_stoch,left_stoch,'.','Markersize',80,'color',pl_color('cyl_fit'));

legend([h2 h3],{'1-harmonic', 'Stochastic'},'Location','southeast');
hold on

xlim([0 0.6])
ylim([0 0.6])

yticks([0  0.3  0.6])
xticks([0  0.3  0.6])


ylabel('<dy^2 / dz^2>')
xlabel('<|dy|>^2 / <|dz|>^2')

plot_set_1x3;










