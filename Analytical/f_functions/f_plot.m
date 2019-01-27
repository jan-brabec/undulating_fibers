function f_plot(m,xps,s,s_i,s_e,D_w,t,w,what_to_plot)
% function f_plot(m,xps,s,s_i,s_e,D_w,t,w,what_to_plot)
%
% Plots
% Structure of what_to_plot=[last gwf, last q_t, last ps_qw, D_w, s(b_t),
% s(b_w)]

%Prepare
    figure('units','normalized','outerposition',[0 0 1 1]);

    %Collect all b-values from the field array to vector to plot:
    for c_exp=1:xps.n_exp
        b_t(c_exp)=xps.gwf(c_exp).b_t;
        b_w(c_exp)=xps.gwf(c_exp).b_t;
    end

    %Choose only last experiment to plot following:
    c_exp=xps.n_exp;

    q_t=xps.gwf(c_exp).q_t;
    ps_q=xps.gwf(c_exp).ps_q;

    
i=1;
    
if what_to_plot(1)==1
    subplot(4,2,i)
    plot(t*1e3,xps.gwf(c_exp).g,'-*');
    title('Last gradient waveform');
    xlabel('t [ms]');
    ylabel('Amplitude [T/m]');
    i=i+1;
end

if what_to_plot(2)==1
    subplot(4,2,i)
    plot(t,q_t);
    title('Last q vector in time domain');
    xlabel('t [s]');
    ylabel('Amplitude [rad/m]'); %T/m; Amplitude of the diffusion gradient
    i=i+1;
end

if what_to_plot(3)==1
    subplot(4,2,i)
    plot(w,ps_q); %real part displayed, not shifted
    title('Last q vector spectrum');
    xlabel('w [Hz]');
    xlim([-300, 300]);
    ylabel('Amplitude [rad/m]'); %T/m; Amplitude of the diffusion gradient
    i=i+1;
end

if what_to_plot(4)==1
    subplot(4,2,i)
    plot(w,D_w)
    title('Diffussion spectrum D(w)');
    ylabel('D(w)')
    xlabel('w [Hz]');
    
    i=i+1;
end

if what_to_plot(5)==1
    subplot(4,2,i)
    semilogy(b_t*1e-9,s); %units from s/m^2 to ms/microm^2
    title('Signal vs b_t curve')
    xlabel('b_t [ms/\mum^2]');
    ylabel('S');
    
    i=i+1;
end

if what_to_plot(6)==1
    subplot(4,2,i)
    semilogy(b_w*1e-9,s); %units from s/m^2 to ms/microm^2
    title('Signal vs b_w curve')
    xlabel('b_w [ms/\mum^2]');
    ylabel('S');
    
    i=i+1;
end

if what_to_plot(7)==1
    subplot(4,2,i)
    semilogy(b_t*1e-9,s_e); %units from s/m^2 to ms/microm^2
    title('Extracelular signal vs b_t curve')
    xlabel('b_w [ms/\mum^2]');
    ylabel('S');
    
    i=i+1;
end

if what_to_plot(8)==1
    subplot(4,2,i)
    semilogy(b_t*1e-9,s_i); %units from s/m^2 to ms/microm^2
    title('Intracelular signal vs b_t curve')
    xlabel('b_w [ms/\mum^2]');
    ylabel('S');
    
end



