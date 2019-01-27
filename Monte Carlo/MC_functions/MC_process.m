function mss = MC_process(mss)
% function mss = MC_process(mss)
%
% Fills out missing parameters in mss based on math functions.
  
   %MC simulator
    [mss.mc.f, mss.mc.df] = MC_get_f_from_df_f_max(mss.mc.f_max,mss.mc.df);
    [mss.mc.t,mss.mc.dt] = MC_get_t_from_f(mss.mc.f, mss.mc.df);
     mss.mc.t_max=max(mss.mc.t);
     mss.mc.n=numel(mss.mc.t);

   %AC simulator
    [mss.ac.f, mss.ac.df] = MC_get_f_from_df_f_max(mss.ac.f_max,mss.ac.df);
    [mss.ac.t,mss.ac.dt] = MC_get_t_from_f(mss.ac.f, mss.ac.df);
     mss.ac.t_max=max(mss.ac.t);
     mss.ac.n=numel(mss.ac.t);
    
end