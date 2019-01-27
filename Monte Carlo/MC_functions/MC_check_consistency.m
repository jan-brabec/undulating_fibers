function MC_check_consistency(mss,m)
% function MC_check_consitency(mss,m)
%
% Checks that user-defined mss and m structures are consistent.

%TO DO:
% Other checks?

if mss.mc.dt>mss.ac.dt
    error('ac.dt needs to be larger than mc.dt')
end

if mss.g.delta

end