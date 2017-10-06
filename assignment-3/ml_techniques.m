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
% Naive Bayes:
model_bayes = fitcnb(X_train, Y_train);
error_bayes = ml_error(model_bayes, X_test, Y_test);

% SVM:
model_svm = fitcsvm(X_train, Y_train);
error_svm = ml_error(model_svm, X_test, Y_test);

% Regression tree
model_tree = fitctree(X_train, Y_train);
error_tree = ml_error(model_tree, X_test, Y_test);

function error_rate = ml_error(model, X_test, Y_test)
labels = predict(model, X_test);
perf = classperf(Y_test, labels);
error_rate = perf.ErrorRate;
end
