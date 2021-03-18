function pplot(fopts,parent,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)

fmt = {'Interpreter','latex','FontSize',17};
fmt_legend = {'Interpreter','latex','FontSize',14};
fonts = 15;
%
Na = length(Ea);
Nb = length(Eb);

[an_values,bn_values] = fopts2an(fopts,Ea,Eb,Nv,tspan);



l = plot(values,sum(([an_values;bn_values] - [amatrix';bmatrix']).^2));grid on;
ax = l.Parent;
ax.XAxis.TickLabelInterpreter = 'latex';
ax.YAxis.TickLabelInterpreter = 'latex';

ax.YAxis.FontSize = fonts;
ax.XAxis.FontSize = fonts;
%%

end
