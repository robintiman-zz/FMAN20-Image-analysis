%% Q1
load('femfel.mat');
close
subplot(1,3,1), imshowpair(femfel1, femfel2)
title('Image difference using imshowpair')
% We see that image 1 is slightly shifted 

% Align the images
im_moved = rgb2gray(femfel1);
im_fixed = rgb2gray(femfel2);
[optimizer, metric] = imregconfig('monomodal');
im_aligned = imregister(im_moved, im_fixed, 'affine', optimizer, metric);

diff_im = im_fixed-im_aligned;
subplot(1,3,2), imshow(diff_im)
title('Aligned image difference')

% Estimate background
background = imopen(diff_im , strel('disk', 15));
final_im = diff_im - background; 
final_im = imadjust(final_im);
final_im = imbinarize(final_im);
final_im = bwareaopen(final_im, 50);
subplot(1,3,3), imshow(final_im)
title('Final result')

%% Q2
load('heart_data.mat');
close all

% Get the mean and standard deviation for the two classes
back_std = std(background_values);
chamb_std = std(chamber_values);
back_mean = mean(background_values);
chamb_mean = mean(chamber_values);

% Determine priors
total_pixels = numel(im);
a_back = -log(numel(background_values)/total_pixels);
a_chamb = -log(numel(chamber_values)/total_pixels);

% Calculate the probabilities for each pixel (negative log-likelihood)
pd_back = -log(normpdf(im, back_mean, back_std)) - a_back;
pd_chamb = -log(normpdf(im, chamb_mean, chamb_std)) - a_chamb;

% start at lambda = 3.5 
for lambda=1:0.01:5
[M, N] = size(im);
n = numel(im);
neigh = edges4connected(M,N);
i = neigh(:,1);
j = neigh(:,2);
% lambda = 0.11;
A = sparse(i,j,lambda,n,n);
T = [pd_back(:) pd_chamb(:)];
T = sparse(T);

[E, theta] = maxflow(A,T);
theta = reshape(theta,M,N);
theta = double(theta);
imshow(theta)
lambda
waitforbuttonpress
end

%% Q3




