function [p,p_start,p_end] = MC_p_init_uniform_length_G(x0,y0,m,G)
% function [p,p_start,p_end] = MC_p_init_uniform_length_G(x0,y0,m,G)
%
%   Initializes particles as uniformly distributed in the whole structure.

    p_start = min(x0,y0); %start p
    total_length=sum(abs(G(1,:)));
    p_end = p_start+total_length; %end p
    p = (p_end-p_start).*rand(m,1) + p_start; 

end

