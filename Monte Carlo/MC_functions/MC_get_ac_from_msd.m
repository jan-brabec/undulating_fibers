function ac = MC_get_ac_from_msd(msd,dt)
% function ac = MC_get_ac_from_msd(msd,dt)
%
%   Returns velocity autocorrelation function from mean square
%   displacement.


if min(size(msd))==1
    der2 = diff(diff(msd))  / dt^2;
    ac = der2 / 2;
    
    %at the end the same as previous
    ac(end+1)=ac(end);
    ac(end+1)=ac(end);
    
else
    der1 = diff(msd, 1, 1)  / dt;
    der2 = diff(der1, 1, 1) / dt;
    ac = der2 / 2;
    
    %at the end the same as previous
    ac(end+1,:)=ac(end,:);
    ac(end+1,:)=ac(end,:);
end

end








% either smoothing
% msd(:,1) = smooth(msd(:,1),38);%
%
% or fit
% or compute directly ft_ac
% or google how to improve derivatives of noisy data
%


% v_0 = (x_second-x_init)/dt;
% ac(1,1) = mean(v_0(:,1).^2);
% ac(1,2) = mean(v_0(:,2).^2);
%
% D0=1.7e-7;
% x_dist = abs(max(x(:,1))-min(x(:,1)));
% y_dist = abs(max(x(:,2))-min(x(:,2)));
% ac(1,1)= 2 * D0/dt * x_dist^2/(x_dist + y_dist)^2; %alternative: 0.9*sqrt(D0);%
% ac(2,1)= 2 * D0/dt * y_dist^2/(x_dist + y_dist)^2;
