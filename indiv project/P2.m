
load fisheriris;

variables = {'SepalLength','SepalWidth','PetalLength','PetalWidth'};
[coeff,score,latent,tsquared,explained] = pca(meas);

%figure;
%scatterhist(meas(:,1),meas(:,2))

figure;
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',variables);

% Get unique species and their indices
unique_species = unique(species);
color = [];
        
% Create a figure
figure;
hold on;

%[p,d] = size(coeff(:,1:2));
%[~,maxind] = max(abs(coeff(:,1:2)),[],1);
%colsign = sign(coeff(maxind + (0:p:(d-1)*p)));
%maxCoefLen = sqrt(max(sum(coeff.^2,2)));
%scores = (maxCoefLen.*(score(:,1:2) ./ max(abs(score(:,1:2))))).*colsign;

%maximum_score = max(max(abs(score(:,1:2))));
%maximum_coeff = max([sqrt(coeff(1,1)^2+coeff(1,2)^2),sqrt(coeff(2,1)^2+coeff(2,2)^2)]);

%score = maximum_coeff*score/maximum_score;

r = [1, 0, 0];
g = [0, 1, 0];
b = [0, 0, 1];
first_setosa = true;
first_versicolor = true;
first_verginica = true;

% Plot the PCA scores with different colors for each species
for i = 1:length(score)
    if all(coloring(species(i)) == r) && first_setosa
        scatter(score(i, 1), score(i, 2), 10, coloring(species(i)), 'filled');
        first_setosa = false;
    elseif all(coloring(species(i)) == g) && first_versicolor
        scatter(score(i, 1), score(i, 2), 10, coloring(species(i)), 'filled');
        first_versicolor = false;  
    elseif all(coloring(species(i)) == b) && first_verginica
        scatter(score(i, 1), score(i, 2), 10, coloring(species(i)), 'filled');
        first_verginica = false; 
    else 
        scatter(score(i, 1), score(i, 2), 10, coloring(species(i)), 'filled','HandleVisibility','off');
    end
end

% Plot the principal component coefficients as arrows
for i = 1:length(variables)
    quiver(0, 0, coeff(i, 1)*2.5, coeff(i, 2)*2.5, 'MaxHeadSize', 0.5, 'AutoScale', 'off', 'LineWidth', 1,"Color","black",'HandleVisibility','off');
    text(coeff(i, 1)*3, coeff(i, 2)*3, variables{i}, 'FontSize', 12, 'FontWeight', 'bold');
end

% Set labels
legend("setosa","Versicolor","Virginica")
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA Biplot');

% Adjust axis for better visualization
axis equal;
grid on;
hold off;

disp(explained)
figure;

hold on
h = gca;
h.YAxis(1).Limits = [0 100];
bar(explained)
plot(1:numel(explained), cumsum(explained), 'o-', 'MarkerFaceColor', 'r')
ylabel('explained variances [%]');
yyaxis right
h = gca;
h.YAxis(2).Limits = [0 100];
h.YAxis(2).Color = h.YAxis(1).Color;
%h.YAxis(2).TickLabel = strcat(h.YAxis(2).TickLabel, 'cumulative explained variances [%]');

xlabel('principal components');
ylabel('cumulative explained variances [%]');
title('explained variances in function of the number of principal components');

hold off


function color = coloring(x) 
    r = [1, 0, 0];
    g = [0, 1, 0];
    b = [0, 0, 1];
    if strcmp(x,"setosa")
        color = r;
    elseif strcmp(x,"versicolor")
        color = g;
    else
        color = b;
    end
end