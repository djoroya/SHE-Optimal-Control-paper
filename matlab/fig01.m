%%
fig = figure('unit','norm','pos',[0 0 0.5 0.6]);
%fig = figure(1);
clf
hold on 
tspan = linspace(0,pi,800);

phi = [0.0  0.5  1.2  1.9  2.3  2.7  pi ];
s  =  [-3   -2   -3   +2   1    0];
u = @(t) s(1)*(phi(1)<=t).*(t<phi(2)) + ...
         s(2)*(phi(2)<=t).*(t<phi(3)) + ...
         s(3)*(phi(3)<=t).*(t<phi(4)) + ...
         s(4)*(phi(4)<=t).*(t<phi(5)) + ...
         s(5)*(phi(5)<=t).*(t<=phi(6));

ax = plot(tspan,u(tspan),'LineWidth',4,'Color',[0.8 0.4 0.4])

ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;

%
box
xlim([0,pi])
ylim([-4 4])
fmt = {'Interpreter','latex','FontSize',28};

title('$u(\tau)$',fmt{:})
xlabel('$\tau$',fmt{:})
xticks([0 pi/4 pi/2 3*pi/4 pi])
xticklabels({'$0$','$\pi/4$','$\pi/2$','$3\pi/4$','$\pi$'})
yticks(-3:1:3)
%%
iter = 0;
for iu = 2:(length(phi)-1)
   iter = iter + 1;
   xline(phi(iu),'Color',0.6 + [0 0 0]) 
   text(phi(iu),3.5,"$\phi_"+iter+"$",fmt{:})
end
%%
iter = 0;
for iu = 2:(length(phi))
   iter = iter + 1;
   xline(phi(iu),'Color',0.6 + [0 0 0]) 
   text(0.5*phi(iu-1) + 0.5*phi(iu) - 0.05,0.35 + s(iter),"$s_"+iter+"$",fmt{:})
end
%%
for i = -3:1:3
   yline(i,'Color',0.6 + [0 0 0]) 
end
%%
print(fig,'../img/fig01.eps','-depsc')