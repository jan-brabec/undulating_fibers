function G_xy = MC_return_G_xy_from_G(G,m)
% function G_xy = MC_return_structure(G,m)
% 
% Returns start and points of the structure for plotting purposes.

   %Initialize
    total_segments=size(G,2);
    
    x0 = m.x0;
    y0 = m.y0;
    
    
   %Initialize first segment
    angle   = G(2,1);     %actual segment angle
    length  = G(1,1);     %actual segment length
    
    xy_first  = [x0,y0];            %corresp. x,y coordinates
    xy_last   = [x0,y0] + [cos(angle)*length,sin(angle)*length];
    
    G_xy(1,1) = x0; %store end and start points
    G_xy(1,2) = y0;
    G_xy(2,1) = xy_last(1);
    G_xy(2,2) = xy_last(2);
    
    for c=1:total_segments 
           
          %Initialize next segment
        if c<total_segments
            length= G(1,c+1);  
            angle = G(2,c+1);
            
                   
            xy_first = xy_last;
            xy_last  = xy_first + [cos(angle)*length,sin(angle)*length];
            
            G_xy(c+2,1)= xy_last(1);
            G_xy(c+2,2)= xy_last(2);
        end

    end