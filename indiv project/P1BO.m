x1 = -6;
x2 = 2;
x3 = -4;
x4 = 4;


numTry = 5;
exploration = linspace(0,1,25);
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
explo = [];
tolerance = 0.1;


numTry = 1;
exploration = 0.166667 ;
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
explo = [];
tolerance = 0.1;

for i = 1:length(exploration)
    disp(i)
    value = 0;
    time = 0;
    for j = 1:numTry

        % Set up design parameters
        X1 = optimizableVariable('x',[x1 x2]);
        X2 = optimizableVariable('y',[x3 x4]);
        vars = [X1,X2];
        
        tic
        % Perform Bayesian Optimization
        %results = bayesopt(@ps_exampleBO,vars,'PlotFcn', [],'AcquisitionFunctionName','expected-improvement-plus', 'ExplorationRatio',exploration(i), 'NumSeedPoints', 4, 'Verbose',0, 'IsObjectiveDeterministic',true);
        results = bayesopt(@ps_exampleBO,vars,'AcquisitionFunctionName','expected-improvement-plus', 'ExplorationRatio',exploration(i), 'NumSeedPoints', 4, 'Verbose',0, 'IsObjectiveDeterministic',true);
        
        T = toc;

        time = time + T/numTry;
        value = value + results.MinObjective/numTry;
        
        if results.MinObjective < maxf
            explo = (exploration(i));
            maxX = results.XAtMinObjective;
            maxf = results.MinObjective;
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

fprintf('best fitness is %f with parameter x = %f and y = %f with exploration ration %f \n', maxf, maxX.x,maxX.y, explo)

F = inf;
ET = inf;
Opti = 0;
for i = 1:length(exploration)
    if F - fitness(i) > tolerance || (abs(F-fitness(i)) < tolerance && executiontime(i) < ET)
       F = fitness(i);
       ET = executiontime(i);
       Opti = exploration(i);
    end
end

figure;
tiledlayout(2,1)
% Top plot
nexttile
plot(exploration,fitness,HandleVisibility="off")
xline(Opti)
legend("optimal parameter")
xlabel('exploration ratio');
ylabel('average fitness');
title('impact of the exploration ratio on the fitness')

% Bottom plot
nexttile
plot(exploration,executiontime)
xline(Opti)
xlabel('exploration ratio');
ylabel('average execution time');
title('impact of the exploration ratio on the execution time')


fprintf('optimal parameter is %f with fitness %f and execution time %f ', Opti, F,ET)


