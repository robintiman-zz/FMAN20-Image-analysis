function [S] = im2segment(im)
im = imbinarize(im,0.8);
% colormap(gray);
% figure
% imagesc(im)
[L, n] = bwlabel(im)
S = cell(1, n);
for i=0:n
    [row, col] = find(L==i);
    seg = zeros(size(im));
    seg(row', col') = 1;
    S{i+1} = seg;
end
