function [muOD,mmuOD] = sa_muOD(x,y)
% function [muOD,mmuOD] = sa_muOD(x,y)
%
%   Returns muOD and mean of muOD of a trajectory

muOD  = sin(atan( diff(y) ./ diff(x ))).^2;
mmuOD = mean(muOD);


end

