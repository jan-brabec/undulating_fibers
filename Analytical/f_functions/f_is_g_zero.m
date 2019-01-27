function f_is_g_zero = f_is_g_zero(g,dt)
% function sa_g_is_zero = f_g_is_zero(g,dt)
%
% Checks if integral over all gradients g is zero.
% If all are zeros returns true, if at least one is non-zero returns false.
% Returns 1 if the gradient is less than threshold (is effectively zero).
% Returns 0 if the gradient is more than threshold (is effectively non-zero).
% Needs as input array of vectors

for c_exp = 1:size(g,2)
    if sum(g(c_exp)*dt) < 1e-12
          f_is_g_zero=1;
          text=['Integral over gradient ',num2str(c_exp),' is zero'];
          disp(text)
    else
          f_is_g_zero = 0;
          text=['Integral over gradient ',num2str(c_exp),' is NOT zero'];
          disp(text)
    end

end
