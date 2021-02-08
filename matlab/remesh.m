
 function new_tspan = remesh(tspan,f,FACTOR,MINSTEP)
 
% minimo avance

    Nt = length(tspan);

    fspan = gradient(f(tspan),tspan);
    %    
    new_unit = cumsum(fspan.^2+MINSTEP)./sum(fspan.^2+MINSTEP);

    f_tspan = @(u) interp1(new_unit,tspan,u,'makima','extrap');

    new_unit_uniform_mesh= linspace(0,1,FACTOR*Nt);
    new_tspan = f_tspan(new_unit_uniform_mesh);

end