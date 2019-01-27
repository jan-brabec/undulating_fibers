function phi = MC_accrue_phase(phi,x,g,dir,c)
% function phi = MC_accrue_phase(phi,x,g,dir,c)
%
% Accrues phase in given direction


for i=1:size(g,1)
    phi(:,i) = phi(:,i) + x(:,dir) * g(i,c);
end
    
    
end