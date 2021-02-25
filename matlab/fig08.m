clear 

compute = true;

Ea = [1 5 7 11 13 15]';
Eb = [1 5 7 11 13 15]';
%
Na = length(Ea);
Nb = length(Eb);

Nv = 50;
values = linspace(-0.80,0.80,Nv);
%%
bmatrix = zeros(length(values),length(Ea));
bmatrix(:,1) = values;
%
amatrix = zeros(length(values),length(Eb));
amatrix(:,1) = values;
%%
Nt =200;
tspan = linspace(0,pi,Nt);

Ucal = linspace(-1,1,5)';

Ucal(1) = Ucal(1) - 0.5;
Ucal(end) = Ucal(end) + 0.5;

eta = 1e3;
%
u0 = 0;
Lterms = {@(u) Leta1(u,eta,Ucal,u0)};

names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];

if compute 
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterm{:},tspan);
        fopts{iter} = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);
    end
    save('data/fig08_a.mat')
else
    load('data/fig08.mat')
end
%%
fig = figure('Unit','norm','pos',[0 0 0.325 0.35],'Color','w');
%fig.Renderer = 'painters';
pplot2(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
%print(fig,'../img/fig08.eps','-depsc')

%%
%%