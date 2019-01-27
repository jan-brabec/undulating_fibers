function zetas_k = f_find_zeros(equation,zeros_wanted)
% function zeta_k = f_find_zeros(equation,d)
%
% Returns zeros of equation amount of zeros.
% Couple of zeros are skipped due to problematic in-built MATLAB fzero
% function. Algorhitm not perfect but good enough.

i=1;
a=0;

persistent zeta_k

         if isempty(zeta_k)
    disp('Computing zeta_k')
    
    
    while a <= zeros_wanted-1
        zeta_k(i)=fzero(equation,i);

        zeta_k(find(isnan(zeta_k))) = []; %Delete NaNs
        zeta_k(find(zeta_k==0)) = [];     %Delete zeros - good idea to check how many values are deleted
        zeta_k(:)=round(zeta_k(:),7);     %floating point accuracy prevented to apply unique function
        zeta_k=unique(zeta_k);            %Delete double values 

        i=i+1;
        a=numel(zeta_k);
        
    end
    
                 end

zetas_k=zeta_k;


