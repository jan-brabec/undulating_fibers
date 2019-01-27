function [x,y,cind] = sa_1_harm_trajectory(a,T,pnts,dl,revolution)
% function [x,y,cind] = sa_1_harm_trajectory(a,T,pnts,dl,revolution)
%
% Generates equidistant (i.e. same dz) harmonic trajectory


if a/T > 0.3
    warning('Ratio amplitude/wavelength larger than 30 %. Too rapid oscillations. Untested part.')
end

x = zeros(1,pnts);
y = zeros(1,pnts);

for i=1:pnts-1
    
    dx_cand = (0.01:0.01:1)*dl;
    
    y_cand = a*sin(2*pi*(x(i)+dx_cand)/T);
    dy_cand = y_cand - y(i);
    dz_cand = sqrt(dx_cand.^2 + dy_cand.^2);
    
    [~,ind] = min(abs(dl - dz_cand));
    
    dz(i) = dz_cand(ind);
    dx(i) = dx_cand(ind);
    dy(i) = dy_cand(ind);
    
    if dz(i) > 2*dl
        warning('Consider adding less noise or lower lower bound of dx_cand');
    end
    
    y(i+1) = y(i) + dy(i);
    x(i+1) = x(i) + dx(i);
    
end

if strcmp(revolution,'1_revolution_from_middle') %for simulations
    ind_1_rev = round(pnts*T/x(end));
    [~,ind2] = min(abs(y(round(pnts/2-ind_1_rev/2):round(pnts/2+ind_1_rev/2))));
    ind2 = round(pnts/2-ind_1_rev/2) + ind2-1;
    cind = ind2:ind2 + ind_1_rev;
    
elseif strcmp(revolution,'1_revolution_from_left') %for n-harmonics
    ind_1_rev = round(pnts*T/x(end));
    cind = 1:ind_1_rev;
    
    x = x(cind);
    y = y(cind);

end


end

