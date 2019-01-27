function [p,p_start,p_end] = MC_p_init_gauss_middle_length_G(x0,y0,m,G)
% function [p,p_start,p_end] = MC_p_init_gauss_middle_length_G(x0,y0,m,G)
%
%   Initializes particle positions in the middle of the structure.

    p_start = min(x0,y0); 
    L=sum(abs(G(1,:))); %total length
    p_end = p_start+L;
    
    p = ones(m,1);
    p = p*L/2;
    
end