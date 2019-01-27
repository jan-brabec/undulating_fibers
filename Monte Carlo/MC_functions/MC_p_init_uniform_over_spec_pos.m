function [p,p_start,p_end] = MC_p_init_uniform_over_spec_pos(m,G,pos_init)
% function [p,p_start,p_end] = MC_p_init_uniform_over_spec_pos(m,G,pos_init)
%
%   Initializes particles as uniformly distributed in some part of the structure defined by
%   specific positions.

p_start = 0; %start p
total_length=sum(abs(G(1,:)));
p_end = total_length; %end p

b = pos_init(1); %end
a = pos_init(2); %%start

p = (b - a).*rand(m,1) + a;

end

