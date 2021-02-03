clear 
Ea = [1 5 7]';
Eb = [1 5 7]';
%
Na = length(Ea);
Nb = length(Eb);

Nv = 20;
values = linspace(-0.25,0.25,Nv);
%%
bmatrix = zeros(length(values),length(Ea));
bmatrix(:,1) = values;
%
amatrix = zeros(length(values),length(Eb));
amatrix(:,1) = values;
%%
Nt = 400;
tspan = linspace(0,pi,Nt);
Lterms = {@(f) +f};

names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];
for Lterm = Lterms
    iter = iter + 1;
    [S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterm{:},Nt);
    fopts{iter} = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);
    ylabelstring = '$\beta_1 = \beta_2$';
end

%%
fig = figure('Unit','norm','pos',[0 0 0.5 0.5]);
pplot(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%

