clear 

compute = false;

Ea = [1 5 7 11 13]';
Eb = [1 5 7 11 13]';
%
Na = length(Ea);
Nb = length(Eb);

Nv = 200;
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

% Ucal(1) = Ucal(1) - 0.05;
% Ucal(end) = Ucal(end) + 0.05;
%%
eta = 1e3;
%
u0 = 0;
Lterms = {@(u) Leta1(u,eta,Ucal,u0)};

clf
uspan = linspace(-2,2,300);
 plot(uspan,Lterms{1}(uspan))

%%
names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];

if compute 
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterm{:},tspan);
        %name_code_c = char("Sfig08_"+names{iter}+".c");
        %S.generate(name_code_c)
        %eval("!gcc -fPIC -shared "+name_code_c+" -o "+name_code_c+".o")
        fopts{iter} = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);
    end
    save('data/fig08_a.mat')
else
    load('data/fig08_a.mat')
end
%%
fig = figure('Unit','norm','pos',[0 0 0.325 0.35],'Color','w');
%fig.Renderer = 'painters';
pplot2(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
print(fig,'../img/fig08.eps','-depsc')

%%
%%