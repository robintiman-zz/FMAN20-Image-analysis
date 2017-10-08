function features = segment2features(I)
features = zeros(10,1);
% Remove influence of position
[row, col] = find(I);
letter = I(min(row)-1:max(row)+1, min(col)-1:max(col)+1);

% Define features:
% Letter width and height 
features(1) = size(letter, 1);
features(2) = size(letter, 2);
% Total pixels (fix)
features(3) = numel(find(letter));
% Mean of pixels in x and y direction
x_sum = sum(letter);
y_sum = sum(letter, 2);
features(4) = mean(x_sum);
features(5) = mean(y_sum);
% Variance of pixels in x and y direction
features(6) = var(x_sum);
features(7) = var(y_sum);
% Mean cross-correlation of x and y
features(8) = mean(xcorr(x_sum, y_sum));
% % Mean of x*x*y and x*y*y
% features(8) = mean(x_sum.*x_sum.*y_sum);
% features(9) = mean(x_sum.*y_sum.*y_sum);

% Edges and enclosed areas 
[edge_indices, labeled] = bwboundaries(letter);
features(9) = size(edge_indices{1}, 1);
features(10) = numel(edge_indices);





% % Diagonal line
% d = diag(cropped);
% features(1) = sum(d);
% 
% % Number of areas
% [indices, labeled] = bwboundaries(cropped);
% nbrpools = numel(indices);
% features(2) = nbrpools;
% 
% % Enclosed area 
% c = ismember(labeled, 2:nbrpools);
% pools = find(c);
% features(3) = numel(pools);
% 
% % Mean central moment of labeled image 
% mom = moment(labeled, 2);
% features(4) = mean(mom);
% 
% % Total area
% features(5) = sum(cropped(:));
% 
% % Vertical line (col 4,5,6)
% line = cropped(:,4:6);
% features(6) = sum(sum(line));