
function [an_values,bn_values] = fopts2an(fopts,Ea,Eb,Nv,tspan)


%
an = @(fspan) (2/pi)*trapz(tspan,fspan.*cos(Ea.*tspan),2);

an_values_cell = arrayfun(@(it) an(fopts(it,:)),1:Nv,'UniformOutput',0);
an_values = [an_values_cell{:}];
%
bn = @(fspan) (2/pi)*trapz(tspan,fspan.*sin(Eb.*tspan),2);

bn_values_cell = arrayfun(@(it) bn(fopts(it,:)),1:Nv,'UniformOutput',0);
bn_values = [bn_values_cell{:}];

end