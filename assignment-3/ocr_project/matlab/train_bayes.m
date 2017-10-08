function classification_data = train_bayes(X,Y)
% Returns a cell array with:
% - Mean of featurse 
% - Standard deviation of features
% - The class ration in training set
classification_data = cell(26, 3);

% The probability of a random sample being in a class
total_instances = numel(Y);
p_class = zeros(1, max(Y));
for i=1:max(Y)
    nbr_class = numel(find(Y==i));
    p_class(i) = nbr_class / total_instances;
    
    % Separate data by class
    class_instances = X(:, Y==i);

    % Calculate mean and standard deviation for each feature in each class
    classification_data{i,1} = mean(class_instances + 1, 2);
    classification_data{i,2} = std(class_instances, 0, 2);
    classification_data{i,3} = p_class(i);
end