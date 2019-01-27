function g_matrix = MC_get_g_from_g_act_g_norm(g_act,g_norm)
% function g_matrix = MC_get_g_from_g_act_g_norm(g_act,g_norm)
%
%   Returns matrix of applied gradients.
%   First coordinate represents consequently applied gradients.
%   Second coordinate corresponds to gradient at given time.

    g_matrix = zeros(numel(g_act),size(g_norm,2));
    
    for i=1:numel(g_act)
        g_matrix(i,:) = g_norm.*g_act(i);
    end 


end

