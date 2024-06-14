load fisheriris;

variables = {'SepalLength','SepalWidth','PetalLength','PetalWidth'};

figure;

r = [1, 0, 0];
g = [0, 1, 0];
b = [0, 0, 1];
first_setosa = true;
first_versicolor = true;
first_verginica = true;

% Plot the PCA scores with different colors for each species
for i = 1:length(meas)
    x = scatter(meas(i, 1),meas(i, 2), 10, coloring(species(i)), 'filled');
    if all(coloring(species(i)) == r) && first_setosa 
        legend(x,"setosa")
        first_setosa = false;
    elseif all(coloring(species(i)) == g) && first_versicolor
        legend(x,"versicolor")
        first_versicolor = false;  
    elseif all(coloring(species(i)) == b) && first_verginica
        legend(x,"verginica")
        first_verginica = false; 
    else 
        legend(x,"")
    end

end

% Set labels
xlabel('SepalLength');
ylabel('SepalWidth');
title('Iris dataset - ground truth');

% Adjust axis for better visualization
axis equal;
grid on;
hold off;

figure;
plot(meas(:,1),meas(:,2),'.');

% Set labels
xlabel('SepalLength');
ylabel('SepalWidth');
title('Iris dataset');

clusters=4;
opts = statset('Display','final');
[idx,C] = kmeans(meas,clusters,'Distance','cityblock',...
    'Replicates',10,'Options',opts);


pouf = true;
figure;

for i=1:1:clusters
if pouf == true
    x = plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3);
    pouf = false;
else
    x = plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3,'HandleVisibility','off');
end
hold on
plot(meas(idx==i,1),meas(idx==i,2),'.','MarkerSize',12, 'MarkerFaceColor', [1 1 0]);

end
legend('centroids','Cluster 1','Cluster 2','Cluster 3','Cluster 4');
xlabel('SepalLength');
ylabel('SepalWidth');
title 'Cluster Assignments and Centroids'
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