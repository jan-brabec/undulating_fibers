function [G,l_distrib,muOD] = MC_G_as_random(rnd_angle,rnd_length,l_default,Angle_default,angle_type,a,b,sigma)
% function [G,l_distrib] = MC_G_as_random(rnd_angle,rnd_length,l_default,Angle_default,angle_type,a,b)
%
%   Generates random structure for given input parameters. Returns
%   structure as array and its size distrib that can be seen as
%   hist(l_distrib).


structure_count = 1;    %total number of structures generated
segment_count   = 599;  %segments per one structure

%Length

if rnd_length == true
    
    l_increment   = gamrnd(a,b,segment_count,structure_count);
    l_for_distrib = gamrnd(a,b,1e6          ,structure_count);
    
    l = (l_default + l_increment)';
    l_distrib = l_default + l_for_distrib;
    %total length distribution ~ gamma(segment_count*a,b) + l_default*segment_count
    
else
    l = repmat(l_default,1,segment_count);
    l_distrib = repmat(l_default,1e6,1);
end

%Angle
if rnd_angle==true
    
    mu    = Angle_default;
    %sigma = pi/4;
    Angle_increment(1,1)=-100;
    
    switch angle_type
        
        case 'gaussian'
            for i=1:segment_count
                Angle_increment(1,i)=-100;
                while Angle_increment(1,i) > sigma || Angle_increment(i) < -sigma
                    Angle_increment(1,i) = normrnd(mu,sigma,structure_count,1);
                end
            end
            Angle = Angle_default + Angle_increment;
        case 'uniform'
            Angle = Angle_default + 2*pi*rand(segment_count,structure_count);
        case 'gaussian_memory'
            Angle(1)=Angle_default;
            for i=2:segment_count
                Angle(i)=normrnd(Angle(i-1),sigma,1,structure_count);
            end
            
            
    end
    
    Angle = Angle';
else
    Angle = repmat(Angle_default,1,segment_count);
end

G=[l;Angle];
muOD = mean(Angle.^2);
%Put everything together, if one wants to add more structures into G that
%this line needs to be changed


end