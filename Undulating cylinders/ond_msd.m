function msd = ond_msd(t,g,T,dt_s,gwf,com,safeprimes_filename, debug,pos)
% function phi = MC_accrue_phase(phi,x,g,dir,c)
%

msd = zeros(3,numel(t));
pos_tmp = pos;


    for c = 1:size(t,2)
        disp(c)
        [pos_tmp,~,~] = do_compartment_simulation_3d(pos_tmp,g,T,dt_s,gwf,com,safeprimes_filename, debug);
%         plot3(pos_tmp(1,:), pos_tmp(2,:), pos_tmp(3,:), '.'), axis equal; drawnow;
        msd(:,c) = mean( double(pos_tmp - pos).^2, 2);
    end
    
end