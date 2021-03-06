function result = ustar(mu,pk,Ucal,eps)

result = 0*mu;

iter = 0;
for imu = mu
    iter = iter + 1;
    result(iter) = Ucal(1)*(imu<eps*pk(1)) + Ucal(end)*(imu>=eps*pk(end));
    
    jiter = 1;
    
    ipk_old = pk(1);
    for ipk = pk(2:end)'
        jiter = jiter + 1;
        result(iter) = result(iter) + Ucal(jiter)*((eps*ipk_old)<imu).*(imu<=(eps*ipk));
        ipk_old = ipk;
    end
end

end

