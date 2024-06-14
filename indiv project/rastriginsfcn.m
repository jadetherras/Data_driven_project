function z = rastriginsfcn(x)
    z = 20 + x(1).^2 + x(2).^2 - 10*(cos(2*pi*x(1))+cos(2*pi*x(2)));
end

