function result = win(u,eta,a,b)
    result = zeros(length(a),length(u),'casadi.SX');
    %result = zeros(length(a),length(u));

    iter = 0;
    for iu = u
        iter = iter + 1;
        result(:,iter) = 0.5*(tanh(eta*(iu-a)) + tanh(eta*(b-iu)));
    end
end