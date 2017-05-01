function [img_eq] = hist_eq(img)

close all

% img = imread(filename);

[counts, binLocations] = imhist(img);
% figure; imhist(img);

counts_cum = cumsum(counts);

L = binLocations(end);

fun = @(x) floor((L - 1) * (counts_cum(x.data) / counts_cum(end)));

img_norm = blockproc(img, [1 1], fun);
% figure; imhist(uint8(img_norm));

% figure; imshowpair(img, img_norm, 'montage');

%% Compare with MATLAB's
figure; imhist(img);

img_eq = histeq(img);

% figure; imhist(img_eq);

% figure; imshowpair(img, img_eq, 'montage');