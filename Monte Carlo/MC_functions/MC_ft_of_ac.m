function ft_ac = MC_ft_of_ac(ac,dt)
% function ft_ac = MC_ft_of_ac(ac,dt)
%
%   Generates cosine transform of velocity autocorrelation function.
%   Generates diffusion spectrum.

if min(size(ac)) == 1
        ac(1)=ac(1)/2; %cosine transform, first data point divided by 2
        ft_ac=real(fftshift(fft(ac*dt)));
       
elseif min(size(ac)) == 2 

    ac(1,:)=ac(1,:)/2; %cosine transform, first data point divided by 2
    ft_ac=real(fftshift(fft(ac*dt)));
    
    ft_ac=[ft_ac(:,2) ft_ac(:,1)]; %swap col, first x, second y

elseif min(size(ac)) == 3
    ac(1,:)=ac(1,:)/2; %cosine transform, first data point divided by 2
    ft_ac=real(fftshift(fft(ac*dt)));
    
end

end

