%% Q1
% Least squars
load('linjepunkter.mat');
A = ones(numel(x), 2);
A(:,1) = x';
psquare = A\y';
scatter(x, y)
f1 = @(x) psquare(1)*x+psquare(2);
hold on
fplot(f1, [-0.05, 0.35])

% Total least squares
N = numel(x);
xsum = sum(x);
ysum = sum(y);
xy = sum(x.*y) - 1/N*(xsum*ysum);
xx = sum(x.^2 - 1/N*(xsum^2));
yy = sum(y.^2) - 1/N*(ysum^2);
% This is calculated according to the lecture slides
A = [xx xy;xy yy];
[V,~] = eig(A);
% Which eigenvector that were correct was checked manually by plotting
% them both. The second one was basically a horiontal line. 
a = V(1,1);
b = V(2,1);
c = -1/N*(a*xsum + b*ysum);
f2 = @(x) (-a*x - c)/b;
fplot(f2, [-0.05, 0.35])
legend('Data points', 'Least squares', 'Total least squares');