function z = rastriginsfcn_BO(in)
x1 = in.x;
x2 = in.y;
z = 20 + x1.^2 + x2.^2 - 10*(cos(2*pi*x1)+cos(2*pi*x2));
end