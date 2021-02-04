function pplot(fopts,parent,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)

fmt = {'Interpreter','latex','FontSize',17};
fmt_legend = {'Interpreter','latex','FontSize',14};
fonts = 15;
%
Na = length(Ea);
Nb = length(Eb);

[an_values,bn_values] = fopts2an(fopts,Ea,Eb,Nv,tspan);

ui1 = uipanel('Parent',parent,'Unit','norm','pos',[0 0 1 1],'BackgroundColor','w');
ui1.BorderWidth = 0;
ax = axes('Parent',ui1);


[v_ms,t_ms]    = meshgrid(values,tspan);

values_fn = linspace(values(1),values(end),200);
tspan_fn = linspace(tspan(1),tspan(end),200);
[v_ms_2,t_ms_2] = meshgrid(values_fn,tspan);

Vq = interp2(v_ms,t_ms,fopts',v_ms_2,t_ms_2,'linear');

surf(v_ms_2,t_ms_2,Vq)
xline(0,'Color','w','LineWidth',2)
ic = colorbar;
ic.Ticks = [-1 0 1];
ic.TickLabelInterpreter = 'latex';
ic.FontSize = 12;
caxis([-1 1])
colormap(jet(100))

title('$u(\tau)$',fmt{:})
shading interp
xlim([values(1) values(end)])
ylim([tspan(1) tspan(end)])

yticks([0 pi/4 pi/2 3*pi/4 pi])
yticklabels({'$0$','$\pi/4$','$\pi/2$','$3\pi/4$','$\pi$'})

xticks([-0.8 -0.4 0 0.4 0.8])
xlabel('$i_a$',fmt{:})
ylabel('$\tau$',fmt{:})

ax.XAxis.TickLabelInterpreter = 'latex';
ax.YAxis.TickLabelInterpreter = 'latex';
view(0,90)

ax.YAxis.FontSize = fonts;
ax.XAxis.FontSize = fonts;
%%

end
