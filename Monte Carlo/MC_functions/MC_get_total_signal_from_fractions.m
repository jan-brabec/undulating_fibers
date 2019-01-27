function [S_total,b_total,ADC_total] = MC_get_total_signal_from_fractions(S_p,b_p,s_frac)
% function [S_total,b_total,ADC_total] = MC_get_total_signal_from_fractions(S_p,b_p)
%
%   Returns total signal, b-value axis and ADC from signal fractions.

n_frac = size(S_p,2); %number
S_total=0;

%Check that all b-values are same otherwise error
for j=2:n_frac
    if b_p{j-1}~=b_p{j}
        error('b-values are not the same')
    end
end

%If they are same one can arbitrarily assign b_total
b_total = b_p{1};



for j=1:n_frac
    S_total = S_total + s_frac(j)*S_p{j}(1,:); %Total signal
end

warning off;
p = polyfit(b_total, log(S_total), 1);
warning on;
ADC_total = -p(1);


end