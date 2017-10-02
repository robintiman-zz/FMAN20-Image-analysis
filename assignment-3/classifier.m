% Split data into training and test set
load('FaceNonFace.mat')
part = cvpartition(200, 'HoldOut', 0.20);
test_indices = test(part);
train_indices = training(part);
X_test = X(:, test_indices);
Y_test = Y(test_indices);
X_train = X(:, train_indices);
Y_train = Y(train_indices);
clear X Y

class_data = class_train(X_train, Y_train);
% Naive Bayes Classifier
function classification_data = class_train(X,Y)
classification_data = 1;
% Separate data by class
face = X(:, Y==1);
nonface = X(:, Y==-1);

% Calculate mean

end

function y = classify(x,classification_data)
end