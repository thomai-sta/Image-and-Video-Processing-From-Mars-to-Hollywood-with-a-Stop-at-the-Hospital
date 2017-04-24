function [] = blur_mean(filename, mask_size)

img = double(imread(filename));

mask = ones(mask_size, mask_size) / (mask_size * mask_size);

img_blurred = conv2(img, mask, 'same');

img_blurred = img_blurred / max(max(img_blurred));

imshow(img_blurred);