x1 = -6;
x2 = 2;
x3 = -4;
x4 = 4;

numTry = 30;
crossover = linspace(0,1,25);
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
cros = [];
tolerance = 10^-1;

numTry = 1;
crossover = 0.625000;
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
cros = [];
tolerance = 10^-1;


for i = 1:length(crossover)
    value = 0;
    time = 0;
    for j = 1:numTry
        % Set the starting values for the optimizer
        nvars = 2; 
        opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotdistance});
        %opts = optimoptions(@ga);
        opts.PopulationSize = 10;
        options.CrossoverFraction = crossover(i);
        
        % Set upper and lower bounds for the variables
        lb = [x1 x3];
        ub = [x2 x4];
        
        % Run genetic algo with the options specified
        tic
        [x,fval] = ga(@ps_example,nvars,[],[],[],[],lb,ub,[], opts);
        T = toc;
        time = time + T/numTry;
        value = value + fval/numTry;
        
        if fval < maxf
            cros = (crossover(i));
            maxX = x;
            maxf = fval;
        end

        % if abs(fval -maxf) < tolerance
        %     cros(length(cros)+1) = crossover(i);
        % elseif fval < maxf
        %     cros = (crossover(i));
        %     maxX = x;
        %     maxf = fval;
        % end
    end
    fitness(i)= value;
    executiontime(i) = time;

    % disp("point")
    % disp(x)
    % disp("value")
    % disp(fval)

    
end

fprintf('best fitness is %f with parameter x = %f and y = %f with fraction %f \n', maxf, maxX(1),maxX(2), cros)

F = inf;
ET = inf;
Opti = 0;
for i = 1:length(crossover)
    if F - fitness(i) > tolerance || (abs(F-fitness(i)) < tolerance && executiontime(i) < ET)
       F = fitness(i);
       ET = executiontime(i);
       Opti = crossover(i);
    end
end

figure;
tiledlayout(2,1)
% Top plot
nexttile
plot(crossover,fitness,HandleVisibility="off")
xline(Opti)
legend("optimal parameter")
xlabel('crossover fraction');
ylabel('average fitness');
title('impact of the crossover fraction on the fitness')

% Bottom plot
nexttile
plot(crossover,executiontime)
xline(Opti)
xlabel('crossover fraction');
ylabel('average execution time');
title('impact of the crossover fraction on the execution time')


fprintf('optimal parameter is %f with fitness %f and execution time %f ', Opti, F,ET)