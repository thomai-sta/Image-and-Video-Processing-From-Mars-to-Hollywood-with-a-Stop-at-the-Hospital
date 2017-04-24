function [] = downsample(filename, mask_size)

img = imread(filename);

img_resized = blockproc(img, [mask_size mask_size], @(x) mean(mean(x.data)));

img_resized = img_resized / max(max(img_resized));

imshow(img_resized)