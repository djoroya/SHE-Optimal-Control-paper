function xend = u2xend(x0,u,Ea,Eb,tspan)

Dspan = (2/pi)*[cos(Ea.*tspan); ...
                sin(Eb.*tspan)];

xend =  sum(diff(tspan).*( 0.5*Dspan(:,1:end-1).*u(1:end-1)+0.5*Dspan(:,2:end  ).*u(2:end )  ),2);

xend = x0 - xend;

end

