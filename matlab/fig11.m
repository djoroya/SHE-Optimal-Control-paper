
load('data/fig08_a.mat')
%%
fig = figure('Unit','norm','pos',[0 0 0.325 0.35],'Color','w');
%fig.Renderer = 'painters';
pplot3(fopts{1},fig,Ea,Eb,Nv,tspan,values,amatrix,bmatrix)
%%
%print(fig,'../img/fig08.eps','-depsc')

%%
%%