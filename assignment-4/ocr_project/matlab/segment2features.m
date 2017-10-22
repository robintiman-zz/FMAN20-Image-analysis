function features = segment2features(I)
features = zeros(15,1);
fixed_height = 70;
% Remove influence of position
[row, col] = find(I);
letter = I(min(row):max(row), min(col):max(col));
scale = fixed_height/size(letter,1);
letter = imresize(letter, scale, 'nearest');
letter = padarray(letter, [2 2], 'both');
% imshow(letter)
% Define features:
% Letter width 
features(1) = size(letter, 2);
% Mean of pixels in x and y direction
x_sum = sum(letter);
y_sum = sum(letter, 2);
features(2) = mean(x_sum);
features(3) = mean(y_sum);
% Variance of pixels in x and y direction
features(4) = var(x_sum);
features(5) = var(y_sum);
% Mean cross-correlation of x and y
% features(6) = mean(xcorr(x_sum, y_sum));
stats = regionprops(letter, 'Area', 'Centroid', 'Extent', 'Eccentricity', ...
    'EquivDiameter', 'EulerNumber', 'Extrema', 'FilledArea', 'Orientation', ...
    'Perimeter', 'Solidity');

features(6) = stats.Area;
features(7) = stats.Centroid(1);
% features(9) = stats.ConvexArea;
% features(10) = stats.Eccentricity;
features(8) = stats.EquivDiameter;
features(9) = stats.EulerNumber;
% features(10) = stats.FilledArea;
% features(14) = stats.Orientation;
features(10) = stats.Perimeter;
% features(16) = stats.Solidity;
extrema = mean(stats.Extrema);
features(11) = extrema(1);
features(12) = extrema(2);

[B,L,N] = bwboundaries(letter);
features(13) = N;
for i=2:length(B)
    features(14) = features(14) + numel(find(L==i));
end

features(15) = stats.Extent*1000;