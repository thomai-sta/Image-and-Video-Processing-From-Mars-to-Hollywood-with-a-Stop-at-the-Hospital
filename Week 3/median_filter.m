function [] = median_filter(filename, filter_size)

close all

img = imread(filename);

%% Add Noise
% img_noise = imnoise(img, 'gaussian', 0, 0.01);
img_noise = imnoise(img, 'salt & pepper', 0.1);


figure; title('Image with noise'); imshowpair(img, img_noise, 'montage');
%% Implement Median Filter
[rows, cols] = size(img);
img_filtered = zeros(size(img));

n = floor(filter_size / 2);

for i = 1:rows
  for j = 1:cols
    if i > n
      s_r = i - n;
    else
      s_r = i;
    end
    if i < rows - n + 1
      e_r = i + n;
    else
      e_r = i;
    end
    if j > n
      s_c = j - n;
    else
      s_c = j;
    end
    if j < cols - n + 1
      e_c = j + n;
    else
      e_c = j;
    end
    block = img_noise(s_r:e_r, s_c:e_c);
    img_filtered(i, j) = median(block(:));
  end
end

%% Compare with MATLAB
img_filtered_mat = medfilt2(img_noise, [filter_size filter_size]);


figure; title('Filtered image');
imshowpair(img_filtered, img_filtered_mat, 'montage');