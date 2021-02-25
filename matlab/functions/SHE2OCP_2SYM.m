function [S,ftraj] = SHE2OCP_2SYM(Ea,Eb,Lterm,tspan)
%
import casadi.*
%%
ma = length(Ea);
aT = zeros(ma,1);

as = SX.sym('a',ma,1);
%%

mb = length(Eb);
bT = zeros(mb,1);

bs = SX.sym('b',mb,1);
%%

Xs = [as;bs]; 


fs = SX.sym('f',1,1); ts = SX.sym('t');

das = (2/pi)*fs*cos(Ea.*ts);
dbs = (2/pi)*fs*sin(Eb.*ts);

dynfcn = Function('f',{ts,Xs,fs},{[das;dbs]});

%%
Nt = length(tspan);
%%
fst = SX.sym('ft',[1 Nt]);
%
Xend = zeros(mb+ma,1);
xt   = [Xend]; 

method = 'rk4';
for it = 2:Nt
    dt = tspan(it) - tspan(it-1);

    switch method
        case 'euler'
            Xend  =  Xend +  dt*dynfcn(tspan(it-1),Xend,fst(:,it-1));
        case 'rk4'
            k1 =  dynfcn(tspan(it-1)        , Xend             , fst(:,it-1));
            k2 =  dynfcn(tspan(it-1)+0.5*dt , Xend + 0.5*k1*dt , 0.5*fst(:,it-1) + 0.5*fst(:,it));
            k3 =  dynfcn(tspan(it-1)+0.5*dt , Xend + 0.5*k2*dt , 0.5*fst(:,it-1) + 0.5*fst(:,it));
            k4 =  dynfcn(tspan(it-1)+dt     , Xend + 1.0*k3*dt , fst(:,it));
            Xend = Xend + (1/6)*dt*(k1 + 2*k2 + 2*k3 + k4);
    end
   xt   = [xt Xend]; 
end

%%
epsilon = 1e-3;
%alpha = 1;

aTs = casadi.SX.sym('aT',size(bT));
bTs = casadi.SX.sym('bT',size(aT));

nlp = struct( 'x' , [fst(:);aTs;bTs]           ,        ...
              'f' , (Xend - [aTs;bTs])'*(Xend-[aTs;bTs]) +      ...
                    epsilon*sum(diff(tspan).*(Lterm(fst(1:end-1)) + Lterm(fst(2:end)))/2),       ...
              'g' , [fst(:);aTs;bTs]   );
          
opt = struct('ipopt',struct('print_level',0,'tol',1e-12));
S = nlpsol('S', 'ipopt', nlp,opt);

ftraj = Function('F',{fst},{xt});

end

