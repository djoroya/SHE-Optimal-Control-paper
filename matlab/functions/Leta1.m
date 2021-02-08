function result = Leta1(u,eta,Ucal,u0)
    PI_k = win(u,eta,Ucal(1:end-1),Ucal(2:end));
    Lval = Lk(u,Ucal,u0);
    
    result = sum(PI_k.*Lval,1);
end