function p = MC_apply_const_restrictions(p,a,b,reflectance)
% function p = MC_apply_const_restrictions(p,a,b,reflectance)
%
%   Applies boundary conditions to prevent particles from moving outside.

%Returns number of wall hits
global hits
hits = hits + numel(p(p < a)) + numel(p(p > b));

%Returns error if boundaries are hit
%if isempty(p(p < a))==0 || isempty(p(p > b))==0
%    error('Some particle escaped, enlarge the structure size')
%end

p(p < a)  =  a+reflectance*(a-p(p < a)); %lower limit
p(p > b) =   b-reflectance*(-b+p(p > b)); %higher limit

%Those cross the other limit will stay just at the opposite boundaries:
p(p < a)  =  a;
p(p > b) =   b;

end

