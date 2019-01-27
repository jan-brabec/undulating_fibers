function D_hi_pred = sa_pred_D_hi(x,y,D0)
% function D_hi_pred = sa_pred_D_hi(x,y,D0)
%
%   Returns prediction D_hi from trajectory

[~,mmuOD] = sa_muOD(x,y);

D_hi_pred = mmuOD * D0;

if D_hi_pred*1e9 > 1.1
    error('D_hi in the untested region where it is unlikely to work')
end


end

