function xy = MC_p2xy(p,G,x0,y0)
% function xy = MC_p2xy(p,G,x0,y0)
%
%   Returns xy particle position after position and structure input


global first_xy last_xy c_first c_last
flag=0;


   %Initialize
    total_segments=size(G,2);

    %Positions are not stored but recomputed each run
    xy=[];
 
   %Initialize first segment
    angle   = G(2,1);     %actual segment angle
    length  = G(1,1);     %actual segment length
    p_first   = 0; %where p starts
    p_last    = p_first + length;     %where p ends
    xy_first  = [x0,y0];            %corresp. x,y coordinates
    xy_last   = [x0,y0] + [cos(angle)*length,sin(angle)*length];
    
    
    for c=1:total_segments 
        
        ind=find(p>=p_first & p<=p_last); %indexes from p within segment(c)
          if isempty(ind)==0
            xy(ind,1)=xy_first(1)+cos(angle)*(p(ind)-p_first);
            xy(ind,2)=xy_first(2)+sin(angle)*(p(ind)-p_first);
          end
          
          %Initialize next segment
        if c<total_segments
            length= G(1,c+1);  
            angle = G(2,c+1);
            
            p_first = p_last;
            p_last =  p_last  + length;
            
            xy_first = xy_last;
            xy_last  = xy_first + [cos(angle)*length,sin(angle)*length];

        end
        
        
        %HERE THE l is measured
        if flag==0 && isempty(ind)==0
            first_xy = [min(xy(ind,1)), max(xy(ind,2))];
            c_first=c;
            flag=1;
        end
        
        if flag==1 && isempty(ind)==0
            last_xy = [min(xy(ind,1)), max(xy(ind,2))];
            c_last=c;
        end
        
        
    end