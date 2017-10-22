function [S] = im2segment(im)
bw = imbinarize(mat2gray(im));
bw = imcomplement(bw);
nbr_letters = 5;
% bwlabel finds the connected components. 
[L, n] = bwlabel(bw);
S = cell(1, n);
pixel_count = zeros(1,n);
for i=1:n
    seg = zeros(size(bw));
    % The indices for component i is filled with white, the rest remains
    % black. 
    letter = L==i;
    pixel_count(i) = nnz(letter);
    seg(letter) = 1;
    S{i} = seg;
end

% Sometimes a pixel can be part of a letter but not in direct contact with
% it. These instances needs to be removed. 
if nbr_letters ~= n
    to_remove = n-nbr_letters;
    [~,i] = sort(pixel_count);
    S(i(1:to_remove)) = [];
end