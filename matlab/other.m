%

f = @(t) exp(-2*t.^2)+cos(4*t).^7;

FACTOR = 2;
MINSTEP = 5;

Nt = 50;
tspan = linspace(0,pi,Nt);

new_tspan = remesh(tspan,f,FACTOR,MINSTEP);
%%
clf
subplot(2,1,1)
plot(tspan,f(tspan),'.-')
for it = 1:3:Nt
    xline(tspan(it))
end
subplot(2,1,2)
plot(new_tspan,f(new_tspan),'.-')
for it = 1:3:(FACTOR*Nt)
    xline(new_tspan(it))
end
