function [] = prediction_errors(filename)

img = double(imread(filename));

%% (-1, 0)
diff = imabsdiff(img(2:end, :), img(1:end - 1, :));
entropy(diff)

imshowpair(img, diff, 'montage')
title('(-1, 0)')

%% (0, 1)
diff_1 = imabsdiff(img(:, 2:end), img(:, 1:end - 1));
entropy(diff_1)

figure
imshowpair(img, diff_1, 'montage')
title('(0, 1)')

%% (-1, 0), (-1, 1), (0, 1)
diff_2 = zeros(size(img));
[rows, cols] = size(img);
for i = 2:rows
  for j = 1:cols - 1
    diff_2(i, j) = (abs(img(i, j) - img(i - 1, j)) +...
                    abs(img(i, j) - img(i - 1, j + 1)) +...
                    abs(img(i, j) - img(i, j + 1))) / 3;
  end
end
entropy(diff_2)

figure
imshowpair(img, diff_2, 'montage')
title('(-1, 0), (-1, 1), (0, 1)')