%%%
fig = genfig();
%fig = figure(1);
%clf
hold on 
tspan = linspace(0,pi,800);
new_span = linspace(pi,2*pi,800);
new_span = new_span(2:end);
fmt = {'Interpreter','latex','FontSize',24};

phi = [0.0  0.5  1.2   2.0  2.5 pi ];
s  =  (1/2)*[0   -1   -2   -1   0 1];
u = @(t) s(1)*(phi(1)<=t).*(t<phi(2)) + ...
         s(2)*(phi(2)<=t).*(t<phi(3)) + ...
         s(3)*(phi(3)<=t).*(t<phi(4)) + ...
         s(4)*(phi(4)<=t).*(t<phi(5)) + ...
         s(5)*(phi(5)<=t).*(t<phi(6)) ;

%% Grid 

xlim([0,2*pi])
ylim([-1.25 1.25])

for i = -2:1:2
   plot([-1000 1000],[i/2 i/2],'Color',0.8 + [0 0 0]) 
end
iter = 0;
for iu = 2:(length(phi)-1)
   iter = iter + 1;
  plot([phi(iu) phi(iu)],[-1000 1000],'Color',0.8 + [0 0 0]) 
  plot(2*pi-[phi(iu) phi(iu)],[-1000 1000],'Color',0.8 + [0 0 0]) 

   %xline(phi(iu),'Color',0.8 + [0 0 0] )
   text(phi(iu),1.1,"$\phi_"+iter+"$",fmt{:})
end
%
iter = 0;
for iu = 2:(length(phi))
   iter = iter + 1;
   text(0.5*phi(iu-1) + 0.5*phi(iu) - 0.05,0.15 + s(iter),"$s_"+iter+"$",fmt{:})
end

  plot([pi pi],[-1000 1000],'Color',0.1 + [0 0 0]) 


%%
uspan = u(tspan);
uall = [uspan -fliplr(uspan)];
uall = uall(1:end-1);
ax = plot([tspan new_span],uall,'LineWidth',4,'Color',[0.8 0.2 0.2],'Marker','none');

ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
box



title('$u(t)$',fmt{:})
xlabel('$t$',fmt{:})
xticks([0  pi/2 pi 3*pi/2 2*pi ])
xticklabels({'$0$','$\pi/2$','$\pi$','$3\pi/2$','$2\pi$'})
yticks((1/2)*(-2:1:2))
yticklabels({'$-1$','$-1/2$','$0$','$1/2$','$1$'})

%%

%%

%%
print(fig,'../img/fig01.eps','-depsc')