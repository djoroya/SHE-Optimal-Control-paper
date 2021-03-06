function result = Leta1(u,eta,Ucal,u0)
    PI_k = win(u,eta,Ucal(1:end-1),Ucal(2:end));
    Lval = Lk(u,Ucal,u0);
    
    result = sum(PI_k(2:end-1,:).*Lval(2:end-1,:)) + Lval(end,:).*theta(u-Ucal(end-1),eta) +  Lval(1,:).*theta(-u+Ucal(2),eta);
end