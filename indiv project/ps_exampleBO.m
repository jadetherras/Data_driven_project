function f = ps_exampleBO(in)

x1 = in.x;
x2 = in.y;

f = zeros(1,size(in,1));
for i = 1:size(in,1)
    if  x1 < -5
        f(i) = (x1+5)^2 + abs(x2);
    elseif x1 < -3
        f(i) = -2*sin(x1) + abs(x2);
    elseif x1 < 0
        f(i) = 0.5*x1 + 2 + abs(x2);
    elseif x1 >= 0
        f(i) = .3*sqrt(x1) + 5/2 +abs(x2);
    end
end
end