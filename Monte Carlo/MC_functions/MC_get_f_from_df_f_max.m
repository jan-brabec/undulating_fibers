function [f, df] = MC_get_f_from_df_f_max(f_max,df)
% function [f, df] = MC_get_f(f_max,df)
%
%   Returns frequency axis from f_max and df

    f=linspace(-f_max,f_max,2*f_max/df+1);
    df = df;

end

