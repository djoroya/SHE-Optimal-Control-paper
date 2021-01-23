%%
fig = genfig();
%fig = figure(1);
clf
hold on 
tspan = linspace(0,pi,800);
fmt = {'Interpreter','latex','FontSize',28};

phi = [0.0  0.5  1.2  1.9  2.3  2.7  pi ];
s  =  (1/3)*[-3   -2   -3   +2   1    0];
u = @(t) s(1)*(phi(1)<=t).*(t<phi(2)) + ...
         s(2)*(phi(2)<=t).*(t<phi(3)) + ...
         s(3)*(phi(3)<=t).*(t<phi(4)) + ...
         s(4)*(phi(4)<=t).*(t<phi(5)) + ...
         s(5)*(phi(5)<=t).*(t<=phi(6));



%% Grid 
for i = -3:1:3
   yline(i/3,'Color',0.8 + [0 0 0]) 
end
iter = 0;
for iu = 2:(length(phi)-1)
   iter = iter + 1;
   xline(phi(iu),'Color',0.8 + [0 0 0]) 
   text(phi(iu),1.1,"$\phi_"+iter+"$",fmt{:})
end
%
iter = 0;
for iu = 2:(length(phi))
   iter = iter + 1;
   xline(phi(iu),'Color',0.8 + [0 0 0]) 
   text(0.5*phi(iu-1) + 0.5*phi(iu) - 0.05,0.15 + s(iter),"$s_"+iter+"$",fmt{:})
end

%%
ax = plot(tspan,u(tspan),'LineWidth',6,'Color',[0.8 0.4 0.4],'Marker','none');

ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
box

xlim([0,pi])
ylim([-1.25 1.25])

title('$u(\tau)$',fmt{:})
xlabel('$\tau$',fmt{:})
xticks([0 pi/4 pi/2 3*pi/4 pi])
xticklabels({'$0$','$\pi/4$','$\pi/2$','$3\pi/4$','$\pi$'})
yticks((1/3)*(-3:1:3))
yticklabels({'$-1$','$-2/3$','$-1/3$','$0$','$1/3$','$2/3$','$1$'})

%%

%%

%%
print(fig,'../img/fig01.eps','-depsc')