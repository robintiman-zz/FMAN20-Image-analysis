clear all;
pixels = 2000;
grayscales = 100;
image = ones(pixels, pixels);
row = linspace(0, 1, pixels);
for i = 1:pixels
    image(i,:) = round((4.*(1-row).*row).*grayscales);
end
res = mat2gray(image, [0, grayscales]);
imshow(res)
