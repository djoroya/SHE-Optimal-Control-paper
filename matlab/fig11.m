clear 
Ucal = linspace(-1,1,5)';

eta = 1e5;
%%%%%
win = @(u,a,b) (a<u).*(u<=b);
Lk   = @(u) (Ucal(2:end) + Ucal(1:end-1)).*(u - Ucal(1:end-1)) + Ucal(1:end-1).^2;
PI_k = @(u) win(u,Ucal(1:end-1),Ucal(2:end));

Leta1 = @(u) (u==-1) + sum(Lk(u).*PI_k(u));
points{1} = {[[-1;-0.5;0;0.5;1],[1;0.25;0;0.25; 1]]};
%%
x1 = Ucal(1:end-1);
x2 = Ucal(2:end);
%
y1 = (x1+1).^2;
y2 = (x2+1).^2;

Lk2 = @(u) (y2 - y1)./(x2-x1).*(u-x1) + y1;

Leta2 = @(u)     0.25*sum(Lk2(u).*PI_k(u));
points{2} = {[[x1 ;1],[0.25*y1; 1]]};

%%
x1 = Ucal(1:end-1);
x2 = Ucal(2:end);
%
y1 = (x1-1).^2;
y2 = (x2-1).^2;

Lk3 = @(u) (y2 - y1)./(x2-x1).*(u-x1) + y1;

Leta3 = @(u)     0.25*sum(Lk3(u).*PI_k(u));
points{3} = {[[x1 ;1],[0.25*y1; 0]]};

%%
Ucal = linspace(-1,1,6)';
Lk   = @(u) (Ucal(2:end) + Ucal(1:end-1)).*(u - Ucal(1:end-1)) + Ucal(1:end-1).^2;
PI_k = @(u) win(u,Ucal(1:end-1),Ucal(2:end));
x1 = Ucal(1:end-1);
x2 = Ucal(2:end);
%
y1 = (x1).^2;
y2 = (x2).^2;

Lk4 = @(u) (y2 - y1)./(x2-x1).*(u-x1) + y1;

Leta4 = @(u)     sum(Lk4(u).*PI_k(u));

points{4} = {[[x1 ;1],[y1; 1]]};

%%
uspan = linspace(-2,2,500);

eps = 0.05;
L_minus = @(u) -u;
L_plus  = @(u) +u;
L_sq    = @(u) -u.^2;

LL = {Leta1,Leta2,Leta3,Leta4};
Nm = 7;
mspan = 0.1*linspace(-1,1,Nm);
color = jet(Nm);
color(5,:) = 0.9*color(5,:);

%
fmt = {'Interpreter','latex','FontSize',24};
fmt_line = {'LineWidth',2,'Color',[0.9 0.4 0.1]};
%fig = genfig();
fig = figure('unit','norm','pos',[0 0 0.405 0.51]);

clf
%
str_title = {'$\mathcal{L}_1(u)$', ...
             '$\mathcal{L}_2(u)$',  ...
              '$\mathcal{L}_3(u)$',  ...
             '$\mathcal{L}_4(u)$'};
         
str_title_H = {'$\mathcal{J}(u,\mu)-\varepsilon u - \mu u$', ...
             '$\mathcal{J}(u,\mu)=\varepsilon u - \mu u$'   , ...
              '$\mathcal{J}(u,\mu)=\varepsilon u - \mu u$'   , ...
             '$\mathcal{J}(u,\mu)=-\varepsilon u^2 $'};



for ii = 1:4
subplot(2,2,ii,'Parent',fig)
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
ylim([-0.25 1.25]) 
yline(0)
xline(0)
grid on
% xlabel('$u$',fmt{:})
xticks([-1 0 1])
yticks([-1 0 1])
box
%
plot(points{ii}{:}(:,1),points{ii}{:}(:,2),'Marker','.','MarkerSize',15,'LineStyle','none','color','k')
end
%%
print(fig,'../img/fig11.eps','-depsc')