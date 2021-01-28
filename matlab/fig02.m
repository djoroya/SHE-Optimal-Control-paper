
phi = [0.0  0.5  1.2  1.9  2.3  2.7  pi ];
s  =  (1/3)*[-3   -2   -3   +2   1    0];
u = @(t) s(1)*(phi(1)<=t).*(t<phi(2)) + ...
         s(2)*(phi(2)<=t).*(t<phi(3)) + ...
         s(3)*(phi(3)<=t).*(t<phi(4)) + ...
         s(4)*(phi(4)<=t).*(t<phi(5)) + ...
         s(5)*(phi(5)<=t).*(t<=phi(6));


%%
F =  @(t) -(2/pi)*[cos(t);cos(5*t);sin(t);sin(5*t)].*u(t);

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
for i = 1:4
ax = plot([tspan],[xt(:,i)],'-','LineWidth',3);
end

%
for i = -3:1:3
   yline(i/3,'Color',0.8 + [0 0 0]) 
end

fmt = {'Interpreter','latex','FontSize',26};

iter = 0;
phi = fliplr(phi)
for iu = 2:(length(phi)-1)
   iter = iter + 1;
   xline(phi(iu),'Color',0.8 + [0 0 0]) 
   text(phi(iu),-0.1,"$\phi_"+(6-iter)+"$",fmt{:})
end
%
ylim([-0.2 0.85])

ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
box


xlim([0 pi])
xticks(0.5*[0  pi/2 pi 3*pi/2 2*pi ])
xticklabels({'$0$','$\pi/4$','$\pi/2$','$3\pi/4$','$\pi$'})
legend('$\alpha_1$','$\alpha_2$','$\beta_1$','$\beta_2$','Interpreter','latex','FontSize',19)
xlabel('$\tau$','Interpreter','latex','FontSize',28)
title('{\boldmath$x(\tau)$} = ({\boldmath$\alpha(\tau)$}, {\boldmath$\beta(\tau)$})','Interpreter','latex','FontSize',20)

print(fig,'../img/fig02.eps','-depsc')