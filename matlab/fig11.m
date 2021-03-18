
load('data/fig08_a.mat') 
%%
fig = figure('Unit','norm','pos',[0 0 0.325 0.35],'Color','w');
%fig.Renderer = 'painters';
subplot(4,1,1)
pplot3(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix,name)
%%
load('data/fig05.mat')
%%
%fig.Renderer = 'painters';
subplot(4,1,2)
pplot3(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
load('data/fig06.mat')
%%
%fig.Renderer = 'painters';
subplot(4,1,3)
pplot3(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
load('data/fig10.mat')
%%
%fig.Renderer = 'painters';
subplot(4,1,4)
pplot3(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)

%%
%print(fig,'../img/fig08.eps','-depsc')

%%
%%