%% Q2
f = [1 4 6 8 7 5 3];
int = interp1(f, 1:7);
figure
plot(int)
hold on
scatter(1:7, f)

%% Q3.1
% Train
c1 = [0.4003 0.3988 0.3998 0.3997 0.4010 0.3995 0.3991];
c2 = [0.2554 0.3139 0.2627 0.3802 0.3287 0.3160 0.2924];
c3 = [0.5632 0.7687 0.0524 0.7586 0.4243 0.5005 0.6769];
xtrain = [c1(1:4) c2(1:4) c3(1:4)];
Y = [ones(1,4) ones(1,4)*2 ones(1,4)*3];
model = fitcknn(xtrain', Y');

% Predict
xtest = [c1(5:end) c2(5:end) c3(5:end)];
label = predict(model, xtest')';

%% Q3.2
m = [0.4 0.3 0.5];
std = [0.01 0.05 0.2];
map = zeros(3, 7*3);
for i=1:3
    map(i,:) = normpdf([c1 c2 c3], m(i), std(i));
end

labels = zeros(1,7*3);
for i=1:7*3
    [~,label] = max(map(:,i));
    labels(i) = label;
end
%% Q5
im = [1 0 0 0;0 1 0 0;0 0 1 0;0 1 0 0];
% P(error) = eps
eps = 0.2;
apriori = [0.3 0.2 0.2 0.3];
P_im_i = zeros(1,4);
P_x = 0;
for i=1:4
    % Test each column
    nbr_wrong = nnz(~im(:,i));
    P_im_i(i) = eps^nbr_wrong*(1-eps)^(4-nbr_wrong);
    P_x = P_x + P_im_i(i) * apriori(i);
end
apost = (P_im_i.*apriori)/P_x;

%% Q6
% Represent the possible images as binary matrices
x = [0 0 0;1 0 0;0 1 0;0 0 1;1 1 0];
B = [1 1 0;1 0 1;1 1 0;1 0 1;1 1 0];
O = [0 1 0;1 0 1;1 0 1;1 0 1;0 1 0];
eight = [0 1 0;1 0 1;0 1 0;1 0 1;0 1 0];
ims = cell(1,3);
ims{1} = B;
ims{2} = O;
ims{3} = eight;

eps_orig_white = 0.3;
eps_orig_black = 0.2;
apriori = [0.3 0.4 0.3];
P_im_i = zeros(1,3);
P_x = 0;
for i=1:3
    % Test each image
    wrong_pixels = abs(x-ims{i});
    wrong_values = x(find(wrong_pixels));
    nbr_orig_white = nnz(wrong_values);
    nbr_orig_black = numel(wrong_values) - nbr_orig_white;
    P_im_i(i) = eps_orig_white^nbr_orig_white * eps_orig_black^nbr_orig_black; 
    P_x = P_x + P_im_i(i) * apriori(i);
end
apost = (P_im_i.*apriori)/P_x
