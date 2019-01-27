function [p,p_start,p_end] = MC_p_init_uniform_over_length(m,G,ratio)
% function [p,p_start,p_end] = MC_p_init_uniform_over_some_segments(x0,y0,m,G,number_of_segments)
%
%   Initializes particles as uniformly distributed in some part of the structure defined by ratio.

p_start = 0; %start p
total_length=sum(abs(G(1,:)));
p_end = total_length; %end p

b=total_length/2+ratio/2*total_length; %end
a=total_length/2-ratio/2*total_length; %%start
c=(1-ratio)*total_length/2; %offset

p = (b - a).*rand(m,1) + c;

end

