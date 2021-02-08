clear 
%
Ea = [1 5 7]';
Eb = [1 5 7]';
%

%%
Na = length(Ea);
Nb = length(Eb);

Nt = 50;
tspan = linspace(0,pi,Nt);

Ucal = linspace(-1,1,5)';

Ucal(1) = Ucal(1) - 0.5;
Ucal(end) = Ucal(end) + 0.5;

eta = 5e2;

Lterms = {@(u) Leta1(u,eta,Ucal,-1)};

fconstraints = [-1,1];
%%

Nv = 50;
values = linspace(-0.80,0.80,Nv);
%%
bmatrix = zeros(length(values),length(Ea));
bmatrix(:,1) = values;
%
amatrix = zeros(length(values),length(Eb));
amatrix(:,1) = values;

%
[S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterms{:},tspan);
fopts{1}  = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);

%%
fb = @(b) interp1(values,sum(fopts{:}),b);

plot(values,fb(values),'.-')

Factor  = 2;
MinStep = 200;
new_values = remesh(values,fb,Factor,MinStep);
%%

ft = @(t) interp1(tspan,sum(fopts{:},2)',t);

plot(tspan,ft(tspan),'.-')

Factor  = 2;
MinStep = 200;
new_tspan = remesh(tspan,ft,Factor,MinStep);
    %%
figure(1)
clf
surf(fopts{1}')
colormap('jet')
shading interp
view(0,90)
%%
bmatrix = zeros(length(values),length(Ea));
bmatrix(:,1) = values;
%
amatrix = zeros(length(values),length(Eb));
amatrix(:,1) = values;

%
[S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterms{:},new_tspan);
fopts{2}  = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);

%%
figure(2)
clf
[vms,tms] = meshgrid(values,tspan);
surf(vms,tms,fopts{2}')
colormap('jet')
shading interp
view(0,90)
