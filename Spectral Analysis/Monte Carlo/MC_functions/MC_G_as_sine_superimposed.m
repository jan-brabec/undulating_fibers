function [G, muOD] = MC_G_as_sine_superimposed(x_start,x_end,segments,a,b,c,d,e)
% function G = MC_G_as_sine(x_start,x_end,segments,a,b,c)
%
%   Generates G structure as sine structure consisting of certain number of segments
%   of length L and amplitude A.
%
%   y = a*sin(b*x)+c

x=linspace(x_start,x_end,segments);
dx=x(2)-x(1);

y=a*(sin((x+dx)*b)-sin((x)*b))+c*(sin((x+dx)*d)-sin((x)*d))+e; %function value

angle=atan(y/dx); %segment angle
l=sqrt(dx.^2+y.^2); %segment lengths

G=[l;angle];

muOD = mean(angle.^2);


end