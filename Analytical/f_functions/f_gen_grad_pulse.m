function g = f_gen_grad_pulse(t, t0, delta, DELTA, a)
% function g = f_gen_grad_pulse(t, delta, DELTA, a)
%
% Generates gradient pulse from initial time t0 and based on standard
% parameters.

g = zeros(numel(t),numel(delta));

for i = 1:numel(delta)
    g((t >= (t0(i)))           & (t < (t0(i) + delta(i))),i) = a(i);
    g((t > (t0(i)+ DELTA(i))) & (t <= (t0(i) + DELTA(i) + delta(i)) ),i) = -a(i);
end

g = g';