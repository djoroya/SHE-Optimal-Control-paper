clear 
load('/Users/djoroya/Dropbox/My Mac (Deyviss’s MacBook Pro)/Documents/GitHub/papers/SHE-Optimal-Control-paper/matlab/data/results.mat')
%%
rng(20)
fmt = {'Interpreter','latex','FontSize',21};
fmt2 = {'Interpreter','latex','FontSize',18};

fig = genfig();
clf
subplot(7,1,[1:4])
hold on
grid on
nsol = length(st(6).solutions());
iter = 0;
N =7;
ind_sol  = randsample(nsol,N);
take_sol = st(1).solutions(ind_sol);
colors = hsv(N);

for is=take_sol
    iter = iter + 1;
    lns = plot(is.mi_span,is.angles','color',colors(iter,:),'LineWidth',2.0);
    ll(iter) = lns(1);
end
legend(ll,[repmat('$\mathcal{S}_',N,1),num2str((1:N)'),repmat('$',N,1)],fmt2{:})
title('$\Phi_{\mathcal{S}_l}^*=\Pi_{\mathcal{S}_l}(m) $',fmt{:})

%%
ax = lns(1);
ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
box
%%
ylim([0 pi/2])
yticks([0  pi/4 pi/2 ])
yticklabels({'$0$','$\pi/4$','$\pi/2$'})

xticks([0 1/2 1])
xticklabels({'$0$','$1/2$','$1$'})

%%

subplot(8,1,[7 8])
hold on
iter = 0;
for is=take_sol
    iter = iter + 1;
    lns = plot(is.mi_span,is.mi_span*0 + iter,'color',colors(iter,:),'LineWidth',9);
end
yticks([])
%lns.Parent.Color = 'none';
%lns.Parent.YAxis.Color = 'none';
title('$\mathcal{R}_{\mathcal{S}_l}$',fmt{:})
box
xlabel('$m$',fmt{:})
ylim([0 N+1])
grid on
xticks([0 1/2 1])
xticklabels({'$0$','$1/2$','$1$'})
%%
ax = lns(1);
ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
%
ax.Parent.YAxis.FontSize = 20;
ax.Parent.XAxis.FontSize = 20;
%%
print(fig,'../img/fig01a.eps','-depsc')