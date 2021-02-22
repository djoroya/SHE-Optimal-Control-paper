clear

uspan = linspace(-2,2,1000);
Ucal = linspace(-1,1,5)';

eta = 1e5;
%%%%%
win = @(u,a,b) 0.5*(tanh(eta*(u-a)) + tanh(eta*(b-u)));
win = @(u,a,b) (a<u).*(u<=b);
Lk   = @(u) (Ucal(2:end) + Ucal(1:end-1)).*(u - Ucal(1:end-1)) + Ucal(1:end-1).^2;
PI_k = @(u) win(u,Ucal(1:end-1),Ucal(2:end));

Leta1 = @(u) (u==-1) + sum(Lk(u).*PI_k(u));
%%%%%

a = 4;
b = (1+a)*(Ucal(1:end-1) + Ucal(2:end));
c = -(1+a)*Ucal(1:end-1).*Ucal(2:end);

Lk2 = @(u) -a*u.^2 + b.*u + c;

Leta2 = @(u)  (u==-1) + sum(Lk2(u).*PI_k(u));
eps = 0.05;
%%%%%%

x1 = Ucal(1:end-1);
x2 = Ucal(2:end);
%
y1 = (x1-1).^2;
y2 = (x2-1).^2;

Lk3 = @(u) (y2 - y1)./(x2-x1).*(u-x1) + y1;

Leta3 = @(u)     (u==-1) + 0.25*sum(Lk3(u).*PI_k(u));
%%
fig = figure('unit','norm','pos',[0 0 0.405 0.8]);

fmt = {'Interpreter','latex','FontSize',20};

ui1 = uipanel('Parent',fig,'pos',[0     -0.05 0.425   1.075],'BackgroundColor','w');
ui2 = uipanel('Parent',fig,'pos',[0.4 -0.05 0.625 1.075],'BackgroundColor','w');

ui1.BorderWidth = 0
ui2.BorderWidth = 0

str_title = {'$\mathcal{L}^{p_1}(u)$', ...
             '$\mathcal{L}^{p_2}(u)$',  ...
             '$\mathcal{L}^{p_3}(u)$'};
         
      
fmt_line = {'LineWidth',2,'Color',[0.9 0.4 0.1]};

iter = 0;
for iLeta = {Leta1,Leta2,Leta3}
    iter = iter + 1 ;
    subplot(3,1,iter,'Parent',ui1)
    hold on
        %
    xlim([-1.25 1.25])
    ylim([-0.15 1.15])
    
    for iU = Ucal
       plot([iU iU],[-1e3 1e3],'color',[1 1 1]*0.9) 
    end
    plot([-1 -1],[-1e3 1e3],'color',[1 1 1]*0.1) 
    plot([0 0],[-1e3 1e3],'color',[1 1 1]*0.1) 

    plot([1 1],[-1e3 1e3],'color',[1 1 1]*0.1) 
    plot([-1e3 1e3],[0 0],'color',[1 1 1]*0.1) 

    
    ax = plot(uspan,iLeta{:}(uspan),fmt_line{:});
    ax.Parent.FontSize = 18;

    ax.Parent.XAxis.TickLabelInterpreter = 'latex';
    ax.Parent.YAxis.TickLabelInterpreter = 'latex';

    for iU = Ucal'
       plot(iU,iLeta{:}(iU),'Marker','.','MarkerSize',20,'Color','k')
    end

%     xlabel('$u$',fmt{:})
    title(str_title{iter},fmt{:})
    box
end


%%


str_title_H = {'$\mathcal{H}_m(u)=mu-\epsilon \mathcal{L}^{p_1}(u)$', ...
             '$\mathcal{H}_m(u)=mu+\epsilon \mathcal{L}^{p_2}(u)$'   , ...
             '$\mathcal{H}_m(u)=mu-\epsilon \mathcal{L}^{p_3}(u)$'};
         
subplot(2,1,1,'Parent',ui2)

Nm = 8;
mspan = 0.08*linspace(-1,1,Nm);
color = jet(Nm);

iter = 0;

for LL = {Leta1,Leta2,Leta3}
    iter = iter + 1;
    subplot(3,1,iter,'Parent',ui2)
    hold on
    for iU = Ucal
       plot([iU iU],[-1e3 1e3],'color',[1 1 1]*0.9) 
    end

    plot([-1 -1],[-1e3 1e3],'color',[1 1 1]*0.1) 
    plot([0 0],[-1e3 1e3],'color',[1 1 1]*0.1) 

    plot([1 1],[-1e3 1e3],'color',[1 1 1]*0.1) 
    plot([-1e3 1e3],[0 0],'color',[1 1 1]*0.1) 

    
    for i = 1:Nm
        Hm = eps*LL{:}(uspan)+mspan(i)*uspan;
        [minH,min_ind] = min(Hm  + 1e3*(abs(uspan)>1));
        plot(uspan,Hm,fmt_line{:},'color',color(i,:));
    end
        
    for i = 1:Nm
        Hm = eps*LL{:}(uspan)+mspan(i)*uspan;
        [minH,min_ind] = min(Hm  + 1e3*(abs(uspan)>1));
        ax = plot(uspan(min_ind),minH,'MarkerFaceColor',color(i,:),'Marker','o','MarkerSize',8,'MarkerEdgeColor','k');
    end
    ax.Parent.XAxis.TickLabelInterpreter = 'latex';
    ax.Parent.YAxis.TickLabelInterpreter = 'latex';
    ax.Parent.FontSize = 18;

    colormap(jet(Nm))
    ic = colorbar;
    ic.TickLabelInterpreter = 'latex';

    ic.Label.String = '$m$';
    ic.Label.Interpreter = 'latex';
    ic.Label.FontSize = 15;
    ic.Ticks = [0 0.5 1];
    ic.TickLabels = num2str((ic.Ticks * 2 -1)');
%     xlabel('$u$',fmt{:})
    xlim([-1.25 1.25]) 
    ylim([-0.11 0.13]) 
    xline(0)

    yline(0)
    xticks([-1 0 1])
    yticks(0.1*[-1 0 1])
    box
    title(str_title_H{iter},fmt{:})

end

print(fig,'../img/fig04.eps','-depsc')
