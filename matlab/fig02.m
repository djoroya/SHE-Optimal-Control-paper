
clear
phi = [0.0  0.5  1.2 2.2     pi ];
s  =  (1/2)*[0   -1   -2   -1   ];
u = @(t) sum(s'.*((phi(1:end-1)'<=t).*(t<phi(2:end)')));


%%
F =  @(t) -(2/pi)*[cos(t);cos(5*t);sin(t);sin(5*t)].*(u(pi-t));

tspan = linspace(0,pi,1000);
tspan2 = linspace(pi+0.1,2*pi,1000);
[~,xt] = ode45(@(t,x) F(t),tspan,[0;0;0;0]);

xt = flipud(xt);
%
fig = genfig();
%fig = figure(2)
%clf
%grid on
hold on


%
for i = -3:1:3
   plot([-1e3 1e3],[i/3 i/3],'Color',0.8 + [0 0 0]) 
end

fmt = {'Interpreter','latex','FontSize',26};

iter = 0;
phi = flipud(phi)
for iu = 2:(length(phi)-1)
   iter = iter + 1;
   plot([phi(iu) phi(iu)],[-1e2 1e2],'Color',0.8 + [0 0 0]) 
   text(phi(iu),-0.1,"$\phi_"+(length(phi)-1-iter)+"$",fmt{:})
end
%
ax2 = plot(tspan,xt,'-','LineWidth',3);

ylim([-0.3 1])
ax = ax2(1);
ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
box


xlim([0 pi])
xticks([0  pi/2 pi])
xticklabels({'$0$','$\pi/2$','$\pi$'})
legend(ax2,'$\alpha_1$','$\alpha_2$','$\beta_1$','$\beta_2$','Interpreter','latex','FontSize',19)
xlabel('$t$','Interpreter','latex','FontSize',28)
title('{\boldmath$x(t)$} = ({\boldmath$\alpha(t)$}, {\boldmath$\beta(t)$})','Interpreter','latex','FontSize',20)

print(fig,'../img/fig02.eps','-depsc')