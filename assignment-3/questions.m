%% Q1
% Routine 1
A = ones(numel(x), 2);
A(:,1) = x';
psquare = A\y';
scatter(x, y)
f = @(x) psquare(1)*x+psquare(2);
hold on
fplot(f, [-0.1, 0.5])
%%
% Routine 2
N = numel(x);
xsum = sum(x);
ysum = sum(y);
xy = sum(x.*y) - 1/N*(xsum*ysum);
xx = sum(x.^2 - 1/N*(xsum^2));
yy = sum(y.^2) - 1/N*(ysum^2);
A = [xx xy;xy yy];
e = eig(A);
% Rewrite the equation to solve
