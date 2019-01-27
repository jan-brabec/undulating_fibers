clear all

T = 50e-6;  %wavelenght
a = 2e-6;   %amplitude

dl = 1e-7; %lenght in dz direction

x(1) = 0;
y(1) = 0;

pnts  = 60000;

phi = 0.99;
n = 0;
for i = 2:pnts
    n(i) = phi * n(i-1) + randn(1,1);
end

N = 55;          %incrasing corr.length

p = n / (std(n) * N);
p = cumsum(p);

p = smooth(p,5);

% p = zeros([1 numel(p)]);    %Tick if generate harmonic
% remark = 'no randomness';   %Tick if generate harmonic

clc
phi(1) = 0;

for i=1:pnts-1
    
    dx_cand = (0.01:0.01:1)*dl;
    
    x_cand = x(i) + dx_cand;
    y_cand = a*sin(2*pi*(x(i)+dx_cand)/T + p(i));
    
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

    phi(i+1) = 2*pi*(x(i)+dx(i))/T + p(i);

end

G_xy = [x' y'];

if (0) %harmonic to make it nice
    ind_1_rev = round(pnts*T/x(end));
    [~,ind2] = min(abs(y(round(pnts/2-ind_1_rev/2):round(pnts/2+ind_1_rev/2))));
    ind2 = round(pnts/2-ind_1_rev/2) + ind2-1;
    cind = ind2:ind2 + ind_1_rev;

else %also stochastic
    ind_1_rev = round(pnts*T/x(end));
    turns = 30; %Choose computed indices to be 30
    cind = round(pnts/2 - ind_1_rev*turns/2) : round(pnts/2 + ind_1_rev*turns/2);
    
end

clf
plot(G_xy(:,1),G_xy(:,2),'Linewidth',2,'Color','blue')
hold on
plot(G_xy(cind,1),G_xy(cind,2),'Linewidth',2,'Color','red')
axis equal