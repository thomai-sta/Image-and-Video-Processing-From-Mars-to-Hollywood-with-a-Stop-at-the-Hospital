function [] = non_local_means(filename, win_size)

close all

global window_size;
window_size = win_size;

img = imread(filename);

%% Add Noise
global img_noise;
% img_noise = imnoise(img, 'gaussian', 0, 0.01);
img_noise = imnoise(img, 'salt & pepper', 0.01);
global rows
global cols
[rows, cols] = size(img_noise);

figure; title('Image with noise'); imshowpair(img, img_noise, 'montage');
global n;
n = floor(window_size / 2);

fun = @non_local;
img_filtered = blockproc(img_noise, [1 1], fun);

figure; imshow(img_filtered); title('Filtered')
end

function pixel = non_local(pix_block)
%% Implement non-local Means
global n;
global img_noise;
global window_size;
global rows
global cols

global block;

loc = pix_block.location;

if loc(1) > n
  s_r = loc(1) - n;
else
  s_r = 1;
end
if loc(1) < rows - n + 1
  e_r = loc(1) + n;
else
  e_r = rows;
end
if loc(2) > n
  s_c = loc(2) - n;
else
  s_c = 1;
end
if loc(2) < cols - n + 1
  e_c = loc(2) + n;
else
  e_c = cols;
end

block = img_noise(s_r:e_r, s_c:e_c);

%% Get similar neighbourhoods
fun = @similar_neighbourhood;
center_pixels = blockproc(img_noise, [window_size window_size], fun);

pixel = mean(mean(center_pixels));
if pixel == 0
%   disp('zero')
  pixel = block(ceil(end / 2), ceil(end / 2));
end

end

function center_pixel = similar_neighbourhood(block_1)
global block
MIN_ERROR = 5;

center_pixel = 0;

if (isequal(size(block), size(block_1.data)))
%   immse(block_1.data, block)
  if immse(block_1.data, block) < MIN_ERROR
    center_pixel = block_1.data(ceil(end / 2), ceil(end / 2));
  end
end

end
