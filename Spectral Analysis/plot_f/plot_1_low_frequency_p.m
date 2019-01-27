addpath('../SA_functions')



if (1)
    clear all;
    D0 = 1.7e-9;
    f = linspace(0,500,1e5);
    
    
    c_c = 3; %NEED TO SWITCH CASES 1, 2 and 3
    n_samples = 1e3;
    
    switch (c_c)
        
        
        case 1 %min dispersion
            
            a = normrnd(2e-6,1e-7,1,n_samples);
            T = normrnd(30e-6,1e-6,1,n_samples);
            
            a = a(a>1e-6 & a<3e-6); %restrict to what we have tested, i.e showed predicted vs. estimated
            T = T(T>10e-6 & T<50e-6);
            
            del = numel(T)-n_samples; %delete randomly the diff so that we get intended number of samples
            ind = randperm(numel(T),del);
            T(ind) = [];
            
            del = numel(a)-n_samples;
            ind = randperm(numel(a),del);
            a(ind) = [];
            
            if numel(a) < n_samples || numel(T) < n_samples
                error('Not enough samples')
            end
            
            
        case 2  %max dispersion undulating only
            
            
            a = gamrnd(1.5527,1.4827e-06,1,n_samples*1e2)+1e-6;
            T = gamrnd(1.3574,3.6232e-05,1,n_samples*1e2)+10e-6;
            
            a = a(a>1e-6 & a<3e-6); %restrict to what we have tested
            T = T(T>10e-6 & T<50e-6);
            
            del = numel(T)-n_samples; %delete randomly the diff so that we get intended number of samples
            ind = randperm(numel(T),del);
            T(ind) = [];
            
            del = numel(a)-n_samples;
            ind = randperm(numel(a),del);
            a(ind) = [];
            
            if numel(a) < n_samples || numel(T) < n_samples
                error('Not enough samples')
            end
            
            
        case 3 %max dispersion undulating & straight
            
            a = gamrnd(1.5527,1.4827e-06,1,n_samples*1e2);
            T = gamrnd(1.3574,3.6232e-05,1,n_samples*1e2)+10e-6;
            
            a = a(a>0.1e-6 & a<3e-6); %restrict
            T = T(T>10e-6 & T<250e-6);
            
            del = numel(T)-n_samples; %delete randomly the diff so that we get intended number of samples
            ind = randperm(numel(T),del);
            T(ind) = [];
            
            del = numel(a)-n_samples;
            ind = randperm(numel(a),del);
            a(ind) = [];
            
            if numel(a) < n_samples || numel(T) < n_samples
                error('Not enough samples')
            end
            
    end
    
    
    
    
    d_omega_avg = sa_n_harm_from_1_harm_distrib(a,T,D0,f);
    
    D_hi    = sa_est_D_hi(d_omega_avg,f);
    f_delta = sa_est_f_delta(d_omega_avg,f);
    
    
    for c_case = 1:2
        if c_case == 1  %fit of p at low freq.
            
            min_hz_l = 0.001;
            max_hz_l = 5;
            min_d_omega_l = 0.001;
            max_d_omega_l = 0.2;
            
            [p1,f_min_l,f_max_l] = sa_fit_p(d_omega_avg,f,min_hz_l,max_hz_l,min_d_omega_l,max_d_omega_l);
        end
        
        if c_case == 2 %fit lower freq.
            
            min_hz_h = 0.001; %absolute freq.
            max_hz_h = 20;
            min_d_omega_h = 0; %relative to D_hi
            max_d_omega_h = 0.5;
            
            [p2,f_min_h,f_max_h] = sa_fit_p(d_omega_avg,f,min_hz_h,max_hz_h,min_d_omega_h,max_d_omega_h);
        end
        
        
    end
    
    
end


if (1)
    
    
    figure;
    h1 = histogram(a*1e6,30);
    h1.FaceColor ='black';
    
    if c_c == 1 || 2 || 3
        xlabel('{\ita} [μm]')
        ylabel('#')
    end
    xlim([0.9 3.1])
    xticks([ 1 2 3])
    
    if c_c == 3 
            xlim([0 3.1])
            xticks([ 0 1 2 3])
    end
    
    hold on;
    
    ax = gca;
    ax.FontSize = 40;
    ax.FontWeight = 'bold';
    ax.TickLength = [0.04 0.02];
    
    set(ax,'tickdir','out');
    set(ax,'linewidth',2);
    
    box off
    legend off
    
    
    
    set(gca,'YTick',[])
    
    figure;
    hold on
    h2 = histogram(T*1e6,30);
    h2.FaceColor = 'black';
    
    if c_c == 1 || 2 || 3
        xlabel('{\it\lambda} [μm]')
        ylabel('#')
    end
    
    xlim([9 51])
    xticks([ 10 30 50])
    if c_c == 3
        xlim([0 251])
        xticks([ 10 100 250])
    end
    hold on;
    
    ax = gca;
    ax.FontSize = 40;
    ax.FontWeight = 'bold';
    ax.TickLength = [0.04 0.02];
    
    set(ax,'tickdir','out');
    set(ax,'linewidth',2);
    
    box off
    legend off
    
    set(gca,'YTick',[])
    
    
    
    
    
    
    
    figure;
    loglog(f,d_omega_avg*1e9, 'linewidth', 7,'Color', pl_color('n-harm'))
    hold on
    
    if c_c == 1 || 2 || 3
        xlabel('log {\itf} [Hz]')
        ylabel('log D({\itf}) [μm^2/ms]')
    end
    
    xticks([10^0 10^1 10^2])
    
    xlim([10^0 10^2])
    ylim([10^-2 0.15])
    plot_set_1x3;
    legend off;
    
    
end

