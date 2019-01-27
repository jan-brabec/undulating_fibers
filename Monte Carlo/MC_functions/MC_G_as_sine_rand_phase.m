function [G, muOD] = MC_G_as_sine_rand_phase(x_start,x_end,segments,a,b,c,sigma)
% function G = MC_G_as_sine(x_start,x_end,segments,a,b,c)
%
%   Generates G structure as sine structure consisting of certain number of segments
%   of length L and amplitude A.
%
%   y = a*sin(b*x)+c

x=linspace(x_start,x_end,segments);
dx=x(2)-x(1);

b_rand = 1+randn(1,segments)*sigma;
%b_rand = ones(1,segments);
y=a*(sin((x+dx)*b.*b_rand)-sin((x)*b.*b_rand))+c; %function value

angle=atan(y/dx); %segment angle

%angle=angle + rand(1,segments)*max(angle)/8;

l=sqrt(dx.^2+y.^2); %segment lengths

G=[l;angle];

muOD = mean(angle.^2);

end