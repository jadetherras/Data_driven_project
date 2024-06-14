x1 = -5;
x2 = 5;
x3 = -5;
x4 = 5;

numTry = 30;
temperature = linspace(1,1000,10);
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
temp = [];
tolerance = 10^-3;


numTry = 1;
temperature = 450;
fitness = [];
executiontime = [];
maxX = [inf,inf];
maxf = inf;
temp = [];
tolerance = 10^-3;

for i = 1:length(temperature)
    value = 0;
    time = 0;
    for j = 1:numTry

        % Set the options for the sa optimizer
        options = optimoptions('simulannealbnd','PlotFcns',...
            {@saplotbestf,@saplotf});
        %options = optimoptions('simulannealbnd');
        options.InitialTemperature = temperature(i);
             
        % Set the starting values for the optimizer - this could be random 
        x0 = [20 20];   % Determines the number of variables
        % Set upper and lower bounds for the variables
        lb = [x1 x3];
        ub = [x2 x4];
        % Run simulated annealing with the options specified
        tic
        [x,fval,exitFlag,output] = simulannealbnd(@rastriginsfcn,x0,lb,ub,options);    
        T = toc;
        time = time + T/numTry;
        value = value + fval/numTry;
        
        if fval < maxf
            temp = (temperature(i));
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

fprintf('best fitness is %f with parameter x = %f and y = %f with temperature %f \n', maxf, maxX(1),maxX(2), temp)

F = inf;
ET = inf;
Opti = 0;
for i = 1:length(temperature)
    if F - fitness(i) > tolerance || (abs(F-fitness(i)) < tolerance && executiontime(i) < ET)
       F = fitness(i);
       ET = executiontime(i);
       Opti = temperature(i);
    end
end

figure;
tiledlayout(2,1)
% Top plot
nexttile
plot(temperature,fitness,HandleVisibility="off")
xline(Opti)
legend("optimal parameter")
xlabel('temperature');
ylabel('average fitness');
title('impact of the temperature on the fitness')

% Bottom plot
nexttile
plot(temperature,executiontime)
xline(Opti)
xlabel('temperature');
ylabel('average execution time');
title('impact of the temperature on the execution time')


fprintf('optimal parameter is %f with fitness %f and execution time %f ', Opti, F,ET)
