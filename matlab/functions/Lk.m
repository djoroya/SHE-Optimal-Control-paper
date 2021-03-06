function result = Lk(u,Ucal,u0)
    result = zeros(length(Ucal)-1,length(u),class(u));
%     result = zeros(length(Ucal)-1,length(u));

    iter = 0;
    
    for iu = u
        iter = iter + 1;
        x1 = Ucal(1:end-1);
        x2 = Ucal(2:end);
        y1 = (x1 - u0).^2;
        y2 = (x2 - u0).^2;
        
        result(:,iter) = (y2-y1)./(x2-x1).*(iu - x1) + y1;
        
    end
end
