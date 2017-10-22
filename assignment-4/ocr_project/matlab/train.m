load('../datasets/ocrsegments.mat')
disp('Training classifier..')
% Calculate feature values
nbr_images = numel(S);
features = zeros(15, nbr_images);
for i=1:nbr_images
    features(:, i) = segment2features(S{i});
end

classification_data = fitcecoc(features', y');
% prediction = predict(classification_data, features');
% perf = classperf(y', prediction);
% perf.ErrorRate
save classification_data.mat classification_data
disp('Done!')