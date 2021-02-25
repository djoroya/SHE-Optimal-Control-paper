uspan = linspace(-2,2,500);

eps = 0.05;
L_minus = @(u) -u;
L_plus  = @(u) +u;
L_sq    = @(u) -u.^2;

LL = {L_minus,L_plus,L_sq};
Nm = 7;
mspan = 0.1*linspace(-1,1,Nm);
color = jet(Nm);
color(5,:) = 0.9*color(5,:);

%
fmt = {'Interpreter','latex','FontSize',24};
fmt_line = {'LineWidth',2,'Color',[0.9 0.4 0.1]};
%fig = genfig();
fig = figure('unit','norm','pos',[0 0 0.405 0.8]);

clf
%
str_title = {'$\mathcal{L}(u)=-u$', ...
             '$\mathcal{L}(u)=u$',  ...
             '$\mathcal{L}(u)=-u^2$'};
         
str_title_H = {'$\mathcal{J}(u,\mu)=\mu u-\epsilon u$', ...
             '$\mathcal{J}(u,\mu)=\mu u+\epsilon u$'   , ...
             '$\mathcal{J}(u,\mu)=\mu u-\epsilon u^2$'};

ui1 = uipanel('Parent',fig,'pos',[0     -0.05 0.425   1.075],'BackgroundColor','w');
ui2 = uipanel('Parent',fig,'pos',[0.4 -0.05 0.625 1.075],'BackgroundColor','w');

ui1.BorderWidth = 0
ui2.BorderWidth = 0
for ii = 1:3
subplot(3,1,ii,'Parent',ui1)
hold on

plot([1 1],[-1e2 1e2],'LineWidth',1.,'Color',0.7*[1 1 1])
plot([-1 -1],[-1e2 1e2],'LineWidth',1.,'Color',0.7*[1 1 1])

ax = plot(uspan,LL{ii}(uspan),fmt_line{:});
ax.Parent.XAxis.TickLabelInterpreter = 'latex';
ax.Parent.YAxis.TickLabelInterpreter = 'latex';

ax.Parent.FontSize = 18;
ax.Parent
title(str_title{ii},fmt{:})
xlim([-1.25 1.25]) 
ylim([-1.5 1.5]) 
yline(0)
xline(0)
grid on
% xlabel('$u$',fmt{:})
xticks([-1 0 1])
yticks([-1 0 1])
box
%
subplot(3,1,ii,'Parent',ui2)
hold on
grid on
plot([1 1],[-1e2 1e2],'LineWidth',1.,'Color',0.7*[1 1 1])
plot([-1 -1],[-1e2 1e2],'LineWidth',1.,'Color',0.7*[1 1 1])

for i = 1:Nm
    Hm = eps*LL{ii}(uspan)+mspan(i)*uspan;
    [minH,min_ind] = min(Hm  + 1e3*(abs(uspan)>1));
    ax = plot(uspan(min_ind),minH,'MarkerFaceColor',color(i,:),'Marker','o','MarkerSize',8,'MarkerEdgeColor','k');
    plot(uspan,Hm,fmt_line{:},'color',color(i,:));
end

ax.Parent.XAxis.TickLabelInterpreter = 'latex';
ax.Parent.YAxis.TickLabelInterpreter = 'latex';
ax.Parent.FontSize = 18;
title(str_title_H{ii},fmt{:})


colormap(jet(Nm))
ic = colorbar;
ic.TickLabelInterpreter = 'latex';

ic.Label.String = '$\mu$';
ic.Label.Interpreter = 'latex';
ic.Label.FontSize = 15;
ic.TickLabels = num2str((ic.Ticks * 2 -1)');
% xlabel('$u$',fmt{:})
xlim([-1.25 1.25]) 
ylim([-0.15 0.15]) 
xline(0)

yline(0)
xticks([-1 0 1])
yticks(0.1*[-1 0 1])
box
end
%%
print(fig,'../img/fig03.eps','-depsc')