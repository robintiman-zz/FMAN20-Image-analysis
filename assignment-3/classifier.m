% Split data into training and test set
load('FaceNonFace.mat')

testruns = 1000;
accumulated_accuracy = 0;
for i=1:testruns
    part = cvpartition(200, 'HoldOut', 0.20);
    test_indices = test(part);
    train_indices = training(part);
    X_test = X(:, test_indices);
    Y_test = Y(test_indices);
    X_train = X(:, train_indices);
    Y_train = Y(train_indices);

    % Train model 
    class_data = train_bayes(X_train, Y_train);
    
    % Predict 
    predictions = zeros(size(X_test,2),1);
    for j=1:size(X_test,2)
        x = X_test(:, j);
        predictions(j) = classify_bayes(x, class_data);
    end

    % Test accuracy
    correct = 0;
    total = numel(predictions);
    for k=1:total
        if predictions(k) == Y_test(k)
            correct = correct + 1;
        end
    end
    accumulated_accuracy = accumulated_accuracy + correct / total;
end  
accuracy = accumulated_accuracy / testruns;
disp('Error rate:');
disp(1-accuracy);

% Naive Bayes Classifier
function classification_data = train_bayes(X,Y)
classification_data = cell(1, 6);

% The probability of a random sample being in a class
nbr_faceclass = numel(find(Y==1));
nbr_nonfaceclass = numel(Y) - nbr_faceclass;
p_faceclass = nbr_faceclass / numel(Y);
p_nonfaceclass = nbr_nonfaceclass / numel(Y);
classification_data{5} = p_faceclass;
classification_data{6} = p_nonfaceclass;

% Separate data by class
face = X(:, Y==1);
nonface = X(:, Y==-1);

% Calculate mean and standard deviation for each feature in each class
classification_data{1} = mean(face, 2);
classification_data{2} = std(face, 0, 2);
classification_data{3} = mean(nonface, 2);
classification_data{4} = std(nonface, 0, 2);
end

function y = classify_bayes(x,classification_data)
face_mean = classification_data{1};
face_std = classification_data{2};
nonface_mean = classification_data{3};
nonface_std = classification_data{4};
p_faceclass = classification_data{5};
p_nonfaceclass = classification_data{6};

% Calculate class probability
p_facefeatures = feature_probability(face_mean, face_std, x);
p_nonfacefeatures = feature_probability(nonface_mean, nonface_std, x);
p_face = log(p_faceclass) + sum(log(p_facefeatures));
p_nonface = log(p_nonfaceclass) + sum(log(p_nonfacefeatures));
if p_face > p_nonface
    y = 1;
else 
    y = -1;
end
end

function p = feature_probability(m, s, x)
% Gaussian probability function
p = zeros(numel(x), 1);
for i=1:numel(x)
    exponent = exp(-(x(i)-m(i))^2/(2*s(i)^2));
    p(i) = 1/(sqrt(2*pi*s(i)^2))*exponent;
end
end




