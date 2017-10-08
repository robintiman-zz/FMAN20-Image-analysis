function [S] = im2segment(im)
imshow(mat2gray(im));
waitforbuttonpress;
bw = arrayfun(@binarize, im);
% bwlabel finds the connected components. 
[L, n] = bwlabel(bw);
S = cell(1, n);
for i=1:n
    seg = zeros(size(bw));
    % The indices for component i is filled with white, the rest remains
    % black. 
    seg(L==i) = 1;
    S{i} = seg;
end

% Binarize function. It is applied to each pixel.  
% return: level - 0 for black, 1 for white. 
function [level] = binarize(value)
threshold = 140;
if value > threshold
    level = 0;
else
    level = 1;
end