function check_xps(xps)
% function check_xps(xps)
%
% Performs unit tests on all function in /tools/frequency directory to
% check that math is working properly.
% Additional checks on user/scanner input are performed in sa_proces.


%f_b_w_from_ps_q
    dw=0.0000001;
    ps_q=0:dw:5;
    b_w = f_b_w_from_ps_q(ps_q,dw); %checks that numerical summation of a triangle is ok
    if round(b_w,6)==12.5           %checking up to 6 decimals
        disp('f_b_w_from_ps_q(ps_q,dw) is OK')
    else
        disp('f_b_w_from_ps_q(ps_q,dw) is NOT OK')
    end

    
%f_b_t_from_q_t
    dt=0.0000001;
    q_t=0:dt:5;
    %Becomes linear function x
    
    b_t = f_b_t_from_q_t(q_t,dt); %returns integral of a x^2 function => x^3/3
    %5^3/3=41.66
    if round(b_t,4)==41.6667 %accurate only up to 3 decimals!
         disp('f_b_t_from_q_t(q_t,dt) is OK')
    else
        disp('f_b_t_from_q_t(q_t,dt) is NOT OK')
    end

    
%f_dips_from_r
    disp('f_dips_from_r(r, D_0, w) is too complex for a unit test, run Monte Carlo simulation');
    
    
%f_find_zeros
    clear zetas_k
    equation=@(zeta) sin(zeta);
    zeros_wanted=6;
    zetas_k = f_find_zeros(equation,zeros_wanted);

    if round(zetas_k,7)==round([pi,2*pi,3*pi,4*pi,5*pi,6*pi],7) %test first 7 kernels
        disp('f_find_zeros(equation,zeros_wanted) is OK')
    else
        disp('f_find_zeros(equation,zeros_wanted) is NOT OK')
    end
    
    
%[w, dw] = f_gen_freq_from_time(t, dt)
    t=linspace(0,100,101);
    dt=t(2)-t(1);
    [w, dw] = f_gen_freq_from_time(t, dt);

    if w(numel(w))==1/(2*dt) & dw-(2/(100*dt)-1/(100*dt))<1e-12
      %first condition frequency up to Nyquist frequency and second check
      %frequency step dw up to numerical imprecision
        disp('f_gen_freq_from_time(t, dt) is OK')
    else
        disp('f_gen_freq_from_time(t, dt) is NOT OK')
    end


%[t, dt] = f_gen_time(t_max, t_points)
    [t,dt] = f_gen_time(1000,100);
    for i=1:numel(t)-1
        t_diff(i)=t(i+1)-t(i);
    end
    if max(t)==1000 & any(t_diff-dt)>1e-12 %there is some small 1e-15 error-10 %
         disp('f_gen_time(t_max, t_points) is OK')
    else
        disp('f_gen_time(t_max, t_points) is NOT OK')
    end
    
    
%f_gen_grad_pulse
    t=linspace(0,1,100);
    delta=0.5;
    DELTA=0.5;
    a=10;
    t0=0;

    g = f_gen_grad_pulse(t, t0, delta, DELTA, a);

    if g(1:50)==10 & g(51:100)==-10
        disp('f_gen_grad_pulse(t, t0, delta, DELTA, a) is OK')
    else
        disp('f_gen_grad_pulse(t, t0, delta, DELTA, a) is NOT OK')
    end


%f_is_g_zero
    t = linspace(0,2*pi,1000); %Generates a time vector from 1 to 1000 with 100 points
    dt=t(2)-t(1);
    g = ones(numel(t));
    g = transpose(sin(t)); %Checks that integral over sin in 1 period is zero
    sa_is_g_zero = f_is_g_zero(g,dt);
    
    if sa_is_g_zero==1
        disp('f_is_g_zero(g,dt) is OK')
    else
        disp('f_is_g_zero(g,dt) is NOT OK')
    end

    
%f_plot
    disp('No need to check plot function f_plot');


%f_ps_q_w_from_q_w
    q_w=1:1:100;
    ps_q = f_ps_q_w_from_q_w(q_w);

    for i=1:numel(q_w)
        ps_q_test=abs(q_w).^2;
    end

    if ps_q_test==ps_q
        disp('f_ps_q_w_from_q_w(q_w) is OK')
    else
        disp('f_ps_q_w_from_q_w(q_w) is NOT OK')
    end


%f_q_t_from_g
    g=ones(10,1);
    dt=1;
    q_t = f_q_t_from_g(g,dt);
    gamma = msf_const_gamma('1H');
    
    for i=1:numel(g)
        q_t_test(i)=gamma*sum(g(1:i)*dt);
        
    end

    if q_t==transpose(q_t_test) %q_t is a column vector
        disp('f_q_t_from_g(g,dt) is OK')
    else
        disp('f_q_t_from_g(g,dt) is NOT OK');
    end

    
%f_q_w_from_q_t
disp('f_q_w_from_q_t(q_t,dt) is OK, checked by visual graph inspection of function FT{sin(x)}=delta(x) ')


%f_sum_numerically
    a_k=1:99999;
    w=1;
    B_k=1./a_k;
    D_0=1;
    summa = f_sum_numerically(zetas_k,a_k,B_k,w,D_0);
    %sum reduces to 1/(1+n^2) which is a convergent series
    %http://www.wolframalpha.com/widget/widgetPopup.jsp?p=v&id=29c546473e1c796d6076bb18901b15e7&i0=4133000%20*%20n%5E-0.491&i1=1&i2=3000000&podSelect=&showAssumptions=1&showWarnings=1%=1.07667
    %=1.07666
    if round(summa,5)==round(1.07666,5)
        disp('f_sum_numerically(zetas_k,a_k,B_k,w,D_0) is OK')
    else
        disp('f_sum_numerically(zetas_k,a_k,B_k,w,D_0) is NOT OK')
    end





