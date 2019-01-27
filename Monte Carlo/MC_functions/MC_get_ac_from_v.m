function ac_from_v = MC_get_ac_from_v(v_act,v_init)
% function ac_from_v = MC_get_ac_from_v(v_act,v_init)
%
%   Returns velocity autocorrelation function from from initial and actual
%   velocity.

ac_from_v = mean(v_act.*v_init);

end
