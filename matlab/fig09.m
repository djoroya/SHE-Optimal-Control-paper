clear 

xspan = linspace(-2,2,500);

f = @(x) sin(2*pi*x);

roots = @(xspan,f) xspan(abs(diff(sign(f(xspan)))) == 2);

ir = roots(xspan,f);

% clf
% plot(xspan,f(xspan))
% hold on 
% plot(ir,0*ir,'r','LineStyle','none','Marker','.')
%%
Ucal = linspace(-1,1,7);


%%
Ea = [1 5 7]';
Eb = [1 5 7]';

Nt = 500;
tspan = linspace(0,pi,Nt);
x0 = [1 0 0 1 0 0]';
u0 = zeros(1,Nt);
u0 = sign(sin(4*tspan));
xend = u2xend(x0,u0,Ea,Eb,tspan);
%%
eta = 1e5;

theta = @(x)0.5 + 0.5*tanh(eta*x);
eps = 1e-1;
%
P = @(u) u.^2;
pk = (P(Ucal(2:end))- P(Ucal(1:end-1)))./(Ucal(2:end) - Ucal(1:end-1));
pk = pk';

%%
mustar= @(xend) sum((2/pi)*[cos(Ea.*tspan);sin(Eb.*tspan)].*xend);

Lcal = @(u) Leta1(u,eta,Ucal,0);
%%

dt = tspan(2) - tspan(1);
J = @(xend) xend'*xend + eps*sum(Lcal(ustar(mustar(xend),pk,Ucal,eps)));

%%
mu_span = linspace(-3*eps,3*eps,100);
plot(mu_span,ustar(mu_span,pk,Ucal,eps))
%%
xend_sym = casadi.SX.sym('x0',6);

nlp = struct('x',xend_sym, 'f',J(xend_sym));
S = casadi.nlpsol('S', 'ipopt', nlp);
disp(S)
%%
sol = S('x0',zeros(6,1))