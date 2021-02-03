function pplot(fopts,parent,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)

fmt = {'Interpreter','latex','FontSize',15};
%
Na = length(Ea);
Nb = length(Eb);

[an_values,bn_values] = fopts2an(fopts,Ea,Eb,Nv,tspan);

ui1 = uipanel('Parent',parent,'Unit','norm','pos',[0 0.5 1 0.5]);
ax = axes('Parent',ui1);
surf(values,tspan,fopts')
colorbar
colormap(jet(7))


shading interp
xlim([values(1) values(end)])
ylim([tspan(1) tspan(end)])

yticks([0 pi/2 pi])
yticklabels({'0','\pi/2','\pi'})

ylabel('$\tau$',fmt{:})
view(0,90)
subplot(2,2,3,'Parent',parent)
plot(values,(amatrix' - an_values).^2,'.-')

legend([repmat('$||\alpha_',Na,1)           , ...
        num2str((1:Na)')                    , ...
        repmat('(\pi) - a_',Na,1)           , ...
        num2str((1:Na)')                    , ...
        repmat(num2str('||^2$'),Na,1)]      , ...
        'Interpreter','latex','FontSize',13,'Location','north')
xlabel('$i_a$',fmt{:})

subplot(2,2,4,'Parent',parent)
plot(values,(bmatrix' - bn_values).^2,'.-')

legend([repmat('$||\beta_',Na,1)            , ...
        num2str((1:Na)')                    , ...
        repmat('(\pi) - b_',Na,1)           , ...
        num2str((1:Na)')                    , ...
        repmat(num2str('||^2$'),Na,1)]      , ...
        'Interpreter','latex','FontSize',13,'Location','north')
xlabel('$i_a$',fmt{:})

end
