

x1 = -5;
x2 = 5;

x = x1:0.1:x2; % Using a finer grid for better visualization
y = x1:0.1:x2;

[X, Y] = meshgrid(x, y);
Z = zeros(size(X));

% Calculate Z values
for i = 1:numel(X)
    Z(i) = rastriginsfcn([X(i), Y(i)]);
end

% Plotting the surface
figure;
mesh(X, Y, Z);
grid on;
colorbar;
xlabel('x');
ylabel('y');
zlabel('z');
title('3D Plot of Rastrigin Function');


x1 = -6;
x2 = 2;
x3 = -4;
x4 = 4;

x = x1:0.1:x2; % Using a finer grid for better visualization
y = x3:0.1:x4;

[X, Y] = meshgrid(x, y);
Z = zeros(size(X));

% Calculate Z values
for i = 1:numel(X)
    Z(i) = ps_example([X(i), Y(i)]);
end

% Plotting the surface
figure;
mesh(X, Y, Z);
grid on;
colorbar;
xlabel('x');
ylabel('y');
zlabel('z');
title('3D Plot of ps example Function');