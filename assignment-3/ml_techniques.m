load('ocrfeaturestrain.mat');
% 13 features, 570 examples. 
% Y = 1..26. 1=A, 2=B, and so on

% Choose two letters to train on and remove every other letter:
% 14=N and 13=M.
X = X';
Y = Y';
NorM = Y==14 | Y==13; 
X = X(NorM,:);
Y = Y(NorM);
part = cvpartition(size(X,1), 'HoldOut', 0.20);
test_indices = test(part);
train_indices = training(part);
X_train = X(train_indices, :);
Y_train = Y(train_indices);
X_test = X(test_indices, :);
Y_test = Y(test_indices);

% Try three machine learning classifiers
error_rates = zeros(3,2);
% Naive Bayes:
model_bayes = fitcnb(X_train, Y_train);
error_rates(1,1) = ml_error(model_bayes, X_test, Y_test);
error_rates(1,2) = ml_error(model_bayes, X_train, Y_train);

% SVM:
model_svm = fitcsvm(X_train, Y_train);
error_rates(2,1) = ml_error(model_svm, X_test, Y_test);
error_rates(2,2) = ml_error(model_svm, X_train, Y_train);

% Regression tree
model_tree = fitctree(X_train, Y_train);
error_rates(3,1) = ml_error(model_tree, X_test, Y_test);
error_rates(3,2) = ml_error(model_tree, X_train, Y_train);

disp(error_rates)

function error_rate = ml_error(model, X_test, Y_test)
labels = predict(model, X_test);
perf = classperf(Y_test, labels);
error_rate = perf.ErrorRate;
end