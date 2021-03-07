clear 

compute = false;

Ea = [1 5 7 11 13]';
Eb = [1 5 7 11 13]';
%
Na = length(Ea);
Nb = length(Eb);

Nv = 200;
Nv = 50;
values = linspace(-0.80,0.80,Nv);
%%
bmatrix = zeros(length(values),length(Ea));
bmatrix(:,1) = values;
%
amatrix = zeros(length(values),length(Eb));
amatrix(:,1) = values;
%%
Nt = 200;
Nt = 100;
tspan = linspace(0,pi,Nt);

Ucal = linspace(-1,1,5)';

Ucal(1) = Ucal(1);
Ucal(end) = Ucal(end) ;

eta = 1e5;

Lterms = {@(u) Leta1(u,eta,Ucal)};

names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];

if compute 
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterm{:},tspan);
        fopts{iter} = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);
    end
    save('data/fig07.mat')
else
    load('data/fig07.mat')
end
%%
%fig = figure('Unit','norm','pos',[0 0 0.3 0.35],'Color','w');
fig = figure(8);
%fig.Renderer = 'painters';
pplot2(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
print(fig,'../img/fig07.eps','-depsc')

print(fig,'../img/fig08.eps','-depsc')

%%
function result = Lk(u,Ucal)
    result = zeros(length(Ucal)-1,length(u),'casadi.SX');
    %result = zeros(length(Ucal)-1,length(u));

    iter = 0;
    
    for iu = u
        iter = iter + 1;
        result(:,iter) = (Ucal(2:end) + Ucal(1:end-1)).*(iu - Ucal(1:end-1)) + Ucal(1:end-1).^2;
    end
end
function result = win(u,eta,a,b)
    result = zeros(length(a),length(u),'casadi.SX');
    %result = zeros(length(a),length(u));

    iter = 0;
    for iu = u
        iter = iter + 1;
        result(:,iter) = 0.5*(tanh(eta*(iu-a)) + tanh(eta*(b-iu)));
    end
end
function result = Leta1(u,eta,Ucal)
    PI_k = win(u,eta,Ucal(1:end-1),Ucal(2:end));
    Lval = Lk(u,Ucal);
    
    result = sum(PI_k.*Lval,1);
end