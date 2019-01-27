function dst = sa_dst_1_harm(a,T)
% function dst = sa_dst_1_harm(a,T)
%
% Returns curve integral for 1-harmonics with high res.

x_dst = linspace(0, T, 1e5);
y_dst = a * sin(2 * pi * x_dst / T);
dx = x_dst(2:end) - x_dst(1:(end-1));
dy = y_dst(2:end) - y_dst(1:(end-1));

dst = sum(sqrt( dx.^2 + dy.^2));


end

