function G = MC_G_as_line(segments,L,angle)
% function G = MC_G_as_line(segments,L,angle)
%
%   Generates G structure as line consisting of certain number of segments
%   of length L at given angle.


    s = [L;angle];
    G = repmat(s,1,segments);

end

